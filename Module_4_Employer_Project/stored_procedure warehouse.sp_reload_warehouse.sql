
COMMENT ON PROCEDURE warehouse.sp_reload_warehouse () IS 'Clears down the staging tables and then transforms the staging data into 
a snowflake schema';

CREATE OR REPLACE PROCEDURE warehouse.sp_reload_warehouse(
	)
LANGUAGE 'sql'

BEGIN ATOMIC
 DELETE FROM warehouse.fact_deal_portfolios;
 DELETE FROM warehouse.fact_deal_coupons;
 DELETE FROM warehouse.dim_deals;
 DELETE FROM warehouse.dim_funds;
 DELETE FROM warehouse.dim_facilities;
 DELETE FROM warehouse.dim_borrower_countries;
 DELETE FROM warehouse.dim_borrowers;
 INSERT INTO warehouse.dim_borrowers (id, name, risk_rating, type_loan, segment, region)  SELECT borrowers.id,
             borrowers.borrower,
             borrowers.risk_rating,
             borrowers.type_loan,
             borrowers.segment,
             borrowers.region
            FROM staging.borrowers;
 WITH country_revenue(id, borrower, country, revenue, ordinal) AS (
          SELECT borrowers.id,
             borrowers.borrower,
             COALESCE(borrowers.country_1, ''::character varying) AS "coalesce",
             COALESCE(borrowers.revenue_country_1, (0)::numeric) AS "coalesce",
             1 AS ordinal
            FROM staging.borrowers
         UNION
          SELECT borrowers.id,
             borrowers.borrower,
             COALESCE(borrowers.country_2, ''::character varying) AS "coalesce",
             COALESCE(borrowers.revenue_country_2, (0)::numeric) AS "coalesce",
             2 AS ordinal
            FROM staging.borrowers
         UNION
          SELECT borrowers.id,
             borrowers.borrower,
             COALESCE(borrowers.country_3, ''::character varying) AS "coalesce",
             COALESCE(borrowers.revenue_country_3, (0)::numeric) AS "coalesce",
             3 AS ordinal
            FROM staging.borrowers
         UNION
          SELECT borrowers.id,
             borrowers.borrower,
             COALESCE(borrowers.country_4, ''::character varying) AS "coalesce",
             COALESCE(borrowers.revenue_country_4, (0)::numeric) AS "coalesce",
             4 AS ordinal
            FROM staging.borrowers
         UNION
          SELECT borrowers.id,
             borrowers.borrower,
             COALESCE(borrowers.country_5, ''::character varying) AS "coalesce",
             COALESCE(borrowers.revenue_country_5, (0)::numeric) AS "coalesce",
             5 AS ordinal
            FROM staging.borrowers
         UNION
          SELECT borrowers.id,
             borrowers.borrower,
             COALESCE(borrowers.country_6, ''::character varying) AS "coalesce",
             COALESCE(borrowers.revenue_country_6, (0)::numeric) AS "coalesce",
             6 AS ordinal
            FROM staging.borrowers
         UNION
          SELECT borrowers.id,
             borrowers.borrower,
             COALESCE(borrowers.country_7, ''::character varying) AS "coalesce",
             COALESCE(borrowers.revenue_country_7, (0)::numeric) AS "coalesce",
             7 AS ordinal
            FROM staging.borrowers
         )
  INSERT INTO warehouse.dim_borrower_countries (name, revenue_percent, borrower_id, ordinal)  SELECT country_revenue.country,
             country_revenue.revenue,
             country_revenue.id,
             country_revenue.ordinal
            FROM country_revenue;
 INSERT INTO warehouse.dim_facilities (borrower_id, name)  SELECT DISTINCT wb.id,
             p.facility_name
            FROM ((staging.borrowers sb
              JOIN warehouse.dim_borrowers wb ON ((wb.id = sb.id)))
              JOIN staging.portfolios p ON (((sb.borrower)::text = (p.borrower)::text)));
 INSERT INTO warehouse.dim_funds (name)  SELECT DISTINCT coupons.fund
            FROM staging.coupons
         UNION
          SELECT DISTINCT portfolios.fund
            FROM staging.portfolios;
 INSERT INTO warehouse.dim_deals (facility_id, name)  SELECT DISTINCT wf.id,
             sp.deal_name
            FROM ((staging.portfolios sp
              JOIN warehouse.dim_borrowers b ON (((sp.borrower)::text = (b.name)::text)))
              JOIN warehouse.dim_facilities wf ON ((((sp.facility_name)::text = (wf.name)::text) AND (wf.borrower_id = b.id))));
 INSERT INTO warehouse.fact_deal_portfolios (deal_id, period_end_date, transfers, gross_balance, principal_additions, co_investor, fund_id)  SELECT d.id,
             sp.date,
                 CASE
                     WHEN (lower((COALESCE(sp.transfers, ''::character varying))::text) = 'y'::text) THEN true
                     ELSE false
                 END AS transfers,
             sp.balance_gross,
             sp.principal_additions,
             sp.co_investor,
             funds.id
            FROM ((((staging.portfolios sp
              JOIN warehouse.dim_borrowers b ON (((sp.borrower)::text = (b.name)::text)))
              JOIN warehouse.dim_facilities f ON ((((sp.facility_name)::text = (f.name)::text) AND (f.borrower_id = b.id))))
              JOIN warehouse.dim_deals d ON ((((sp.deal_name)::text = (d.name)::text) AND (d.facility_id = f.id))))
              JOIN warehouse.dim_funds funds ON (((sp.fund)::text = (funds.name)::text)));
 INSERT INTO warehouse.fact_deal_coupons (deal_id, period_end_date, balance_fair_value, coupon_percent, coupon_category, maturity, fund_id)  SELECT d.id,
             sc.date_eom,
             COALESCE(sc.balance_fv, (0)::numeric) AS balance_fair_value,
             COALESCE(sc.coupon, (0)::numeric) AS coupon,
             COALESCE(sc.coupon_category, ''::character varying) AS "coalesce",
             sc.maturity,
             funds.id
            FROM ((((staging.coupons sc
              JOIN warehouse.dim_borrowers b ON (((sc.borrower)::text = (b.name)::text)))
              JOIN warehouse.dim_facilities f ON ((f.borrower_id = b.id)))
              JOIN warehouse.dim_deals d ON ((((sc.deal_name)::text = (d.name)::text) AND (d.facility_id = f.id))))
              JOIN warehouse.dim_funds funds ON (((sc.fund)::text = (funds.name)::text)))
           WHERE (((sc.deal_name)::text <> ''::text) AND (sc.deal_name IS NOT NULL));
END;

ALTER PROCEDURE warehouse.sp_reload_warehouse()
    OWNER TO postgres;
