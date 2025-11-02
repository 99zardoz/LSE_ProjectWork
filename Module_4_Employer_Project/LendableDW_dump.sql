--
-- PostgreSQL database dump
--

\restrict aCRcbwVGfc2aj0fpSmhhZGflN5wzDeAol4I5VXg7kEsqrPT46MEOG8l4yKlXi9y

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-09-06 09:11:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'WIN1252';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 16885)
-- Name: data_quality; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA data_quality;


ALTER SCHEMA data_quality OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 236 (class 1259 OID 17004)
-- Name: borrower_data_issue_details; Type: TABLE; Schema: data_quality; Owner: postgres
--

CREATE TABLE data_quality.borrower_data_issue_details (
    id integer NOT NULL,
    borrower_data_issue_id integer NOT NULL,
    field_name character varying(50) NOT NULL,
    description character varying(50) NOT NULL
);


ALTER TABLE data_quality.borrower_data_issue_details OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17003)
-- Name: borrower_data_issue_details_id_seq; Type: SEQUENCE; Schema: data_quality; Owner: postgres
--

ALTER TABLE data_quality.borrower_data_issue_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME data_quality.borrower_data_issue_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 16996)
-- Name: borrower_data_issues; Type: TABLE; Schema: data_quality; Owner: postgres
--

CREATE TABLE data_quality.borrower_data_issues (
    id integer NOT NULL,
    borrower character varying(50),
    risk_rating integer,
    type_loan character varying(10),
    segment character varying(50),
    country_1 character varying(200),
    country_2 character varying(200),
    country_3 character varying(200),
    country_4 character varying(200),
    country_5 character varying(200),
    country_6 character varying(200),
    country_7 character varying(200),
    revenue_country_1 numeric(5,2),
    revenue_country_2 numeric(5,2),
    revenue_country_3 numeric(5,2),
    revenue_country_4 numeric(5,2),
    revenue_country_5 numeric(5,2),
    revenue_country_6 numeric(5,2),
    revenue_country_7 numeric(5,2),
    process_summary_id integer NOT NULL,
    region character varying(50)
);


ALTER TABLE data_quality.borrower_data_issues OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17147)
-- Name: coupon_data_issue_details; Type: TABLE; Schema: data_quality; Owner: postgres
--

CREATE TABLE data_quality.coupon_data_issue_details (
    id integer NOT NULL,
    coupon_data_issue_id integer NOT NULL,
    field_name character varying(50) NOT NULL,
    description character varying(50) NOT NULL
);


ALTER TABLE data_quality.coupon_data_issue_details OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17146)
-- Name: coupon_data_issue_details_id_seq; Type: SEQUENCE; Schema: data_quality; Owner: postgres
--

ALTER TABLE data_quality.coupon_data_issue_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME data_quality.coupon_data_issue_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 237 (class 1259 OID 17120)
-- Name: coupon_data_issues; Type: TABLE; Schema: data_quality; Owner: postgres
--

CREATE TABLE data_quality.coupon_data_issues (
    id integer NOT NULL,
    borrower character varying(50),
    deal_name character varying(50),
    fund character varying(10),
    date_eom date,
    coupon_category character varying(10),
    maturity date,
    balance_fv numeric(15,5),
    coupon numeric(5,2),
    process_summary_id bigint NOT NULL
);


ALTER TABLE data_quality.coupon_data_issues OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16897)
-- Name: portfolio_data_issue_details; Type: TABLE; Schema: data_quality; Owner: postgres
--

CREATE TABLE data_quality.portfolio_data_issue_details (
    id integer NOT NULL,
    portfolio_data_issue_id integer NOT NULL,
    field_name character varying(50) NOT NULL,
    description character varying(50) NOT NULL
);


ALTER TABLE data_quality.portfolio_data_issue_details OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16896)
-- Name: portfolio_data_issue_details_id_seq; Type: SEQUENCE; Schema: data_quality; Owner: postgres
--

ALTER TABLE data_quality.portfolio_data_issue_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME data_quality.portfolio_data_issue_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16891)
-- Name: portfolio_data_issues; Type: TABLE; Schema: data_quality; Owner: postgres
--

CREATE TABLE data_quality.portfolio_data_issues (
    id integer NOT NULL,
    borrower character varying(50),
    facility_name character varying(50),
    deal_name character varying(50),
    transfers character varying(1),
    co_investor character varying(50),
    fund character varying(10),
    date date,
    segment character varying(50),
    balance_gross numeric(15,5),
    principal_additions numeric(15,5),
    process_summary_id bigint
);


ALTER TABLE data_quality.portfolio_data_issues OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16991)
-- Name: process_summaries; Type: TABLE; Schema: data_quality; Owner: postgres
--

CREATE TABLE data_quality.process_summaries (
    id integer NOT NULL,
    run_date_time timestamp without time zone NOT NULL,
    valid_rows bigint,
    rows_with_issues bigint
);


ALTER TABLE data_quality.process_summaries OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16990)
-- Name: process_summaries_id_seq; Type: SEQUENCE; Schema: data_quality; Owner: postgres
--

ALTER TABLE data_quality.process_summaries ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME data_quality.process_summaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 16954)
-- Name: valuation_data_issue_details; Type: TABLE; Schema: data_quality; Owner: postgres
--

CREATE TABLE data_quality.valuation_data_issue_details (
    id integer NOT NULL,
    valuation_data_issue_id integer NOT NULL,
    field_name character varying(50) NOT NULL,
    description character varying(50) NOT NULL
);


ALTER TABLE data_quality.valuation_data_issue_details OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16953)
-- Name: valuation_data_issue_details_id_seq; Type: SEQUENCE; Schema: data_quality; Owner: postgres
--

ALTER TABLE data_quality.valuation_data_issue_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME data_quality.valuation_data_issue_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 16948)
-- Name: valuation_data_issues; Type: TABLE; Schema: data_quality; Owner: postgres
--

CREATE TABLE data_quality.valuation_data_issues (
    id integer NOT NULL,
    date date,
    rocketlend numeric(5,2),
    omnifund numeric(5,2),
    cargospeed numeric(5,2),
    alphalend numeric(5,2),
    horizoncapital numeric(5,2),
    process_summary_id bigint
);


ALTER TABLE data_quality.valuation_data_issues OWNER TO postgres;

--
-- TOC entry 4973 (class 0 OID 17004)
-- Dependencies: 236
-- Data for Name: borrower_data_issue_details; Type: TABLE DATA; Schema: data_quality; Owner: postgres
--

COPY data_quality.borrower_data_issue_details (id, borrower_data_issue_id, field_name, description) FROM stdin;
3081	1	Country 1	ValueOutOfRange
3082	2	Country 2	ValueOutOfRange
3083	3	Country 1	ValueOutOfRange
3084	4	Risk rating	ValueOutOfRange
3085	5	Country 1	ValueOutOfRange
3086	6	Risk rating	ValueOutOfRange
3087	7	Risk rating	ValueOutOfRange
3088	8	Risk rating	ValueOutOfRange
3089	9	Risk rating	ValueOutOfRange
3090	10	Risk rating	ValueOutOfRange
3091	11	Risk rating	ValueOutOfRange
3092	12	Risk rating	ValueOutOfRange
3093	13	Risk rating	ValueOutOfRange
3094	14	Country 1	ValueOutOfRange
3095	15	Risk rating	ValueOutOfRange
3096	16	Risk rating	ValueOutOfRange
3097	17	Risk rating	ValueOutOfRange
3098	18	Country 2	ValueOutOfRange
3099	19	Risk rating	ValueOutOfRange
3100	20	Country 2	ValueOutOfRange
3101	20	Country 3	ValueOutOfRange
3102	21	Risk rating	ValueOutOfRange
3103	22	Country 1	ValueOutOfRange
3104	23	Risk rating	ValueOutOfRange
\.


--
-- TOC entry 4971 (class 0 OID 16996)
-- Dependencies: 234
-- Data for Name: borrower_data_issues; Type: TABLE DATA; Schema: data_quality; Owner: postgres
--

COPY data_quality.borrower_data_issues (id, borrower, risk_rating, type_loan, segment, country_1, country_2, country_3, country_4, country_5, country_6, country_7, revenue_country_1, revenue_country_2, revenue_country_3, revenue_country_4, revenue_country_5, revenue_country_6, revenue_country_7, process_summary_id, region) FROM stdin;
1	ApexCredit	2	Secured	Consumer Finance	Philippines	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Asia
2	AutoFlow	5	Secured	Embedded Finance	Uganda	Cote d'Ivoire	\N	\N	\N	\N	\N	0.45	0.55	\N	\N	\N	\N	\N	117	Africa
3	BlazeMoney	3	Secured	Asset Finance	Vietnam	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Asia
4	BrightFund	0	-	MSME Finance	Indonesia	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Asia
5	CasaFund	5	Secured	Embedded Finance	Philippines	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Asia
6	CashHive	0	-	MSME Finance	Egypt	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
7	CivicCapital	0	-	Consumer Finance	Kenya	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
8	GreenEdge	0	-	Consumer Finance	Nigeria	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
9	HaloCapital	0	-	Asset Finance	Kenya	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
10	InsightLend	0	-	Consumer Finance	Nigeria	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
11	KopaPay	0	-	MSME Finance	Kenya	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
12	OrbitFinance	0	-	Asset Finance	South Africa	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
13	QuestCapital	0	-	Consumer Finance	Kenya	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
14	QuickAdvance	5	Secured	Consumer Finance	Philippines	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Asia
15	RideFund	0	-	Asset Finance	Kenya	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
16	SummitPartners	0	-	Consumer Finance	Kenya	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
17	SunPower	0	-	Asset Finance	Kenya	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
18	SwiftPay	3	Secured	Payment Platforms	Ghana	Tanzania	\N	\N	\N	\N	\N	0.72	0.28	\N	\N	\N	\N	\N	117	Africa
19	TaskForce	0	-	MSME Finance	Thailand	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Asia
20	ThunderPay	4	Unsecured	Payment Platforms	Kenya	Philippines	Tanzania	South Africa	Indonesia	Thailand	Uganda	0.33	0.16	0.14	0.10	0.10	0.10	0.08	117	Africa/Asia
21	TrailblazeCapital	0	-	Consumer Finance	Kenya	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
22	TrustLend	3	Secured	Consumer Finance	Philippines	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Asia
23	TrustNet	0	-	Consumer Finance	Ghana	\N	\N	\N	\N	\N	\N	1.00	\N	\N	\N	\N	\N	\N	117	Africa
\.


--
-- TOC entry 4976 (class 0 OID 17147)
-- Dependencies: 239
-- Data for Name: coupon_data_issue_details; Type: TABLE DATA; Schema: data_quality; Owner: postgres
--

COPY data_quality.coupon_data_issue_details (id, coupon_data_issue_id, field_name, description) FROM stdin;
37805	5		Duplicate
\.


--
-- TOC entry 4974 (class 0 OID 17120)
-- Dependencies: 237
-- Data for Name: coupon_data_issues; Type: TABLE DATA; Schema: data_quality; Owner: postgres
--

COPY data_quality.coupon_data_issues (id, borrower, deal_name, fund, date_eom, coupon_category, maturity, balance_fv, coupon, process_summary_id) FROM stdin;
5	SwiftPay	\N	BOF	2025-06-30	<12%	2026-06-11	5000000.00000	0.23	117
\.


--
-- TOC entry 4965 (class 0 OID 16897)
-- Dependencies: 222
-- Data for Name: portfolio_data_issue_details; Type: TABLE DATA; Schema: data_quality; Owner: postgres
--

COPY data_quality.portfolio_data_issue_details (id, portfolio_data_issue_id, field_name, description) FROM stdin;
511	1		Duplicate
512	2		Duplicate
513	3		Duplicate
514	4		Duplicate
515	5		Duplicate
516	6		Duplicate
517	7		Duplicate
518	8		Duplicate
519	9		Duplicate
520	10		Duplicate
521	11		Duplicate
522	12		Duplicate
523	13		Duplicate
524	14		Duplicate
525	15		Duplicate
526	16		Duplicate
527	17		Duplicate
528	18		Duplicate
529	19		Duplicate
530	20		Duplicate
531	21		Duplicate
532	22		Duplicate
533	23		Duplicate
534	24		Duplicate
535	25		Duplicate
536	26		Duplicate
537	27		Duplicate
538	28		Duplicate
539	29		Duplicate
540	30		Duplicate
541	31		Duplicate
542	32		Duplicate
543	33		Duplicate
544	34		Duplicate
\.


--
-- TOC entry 4963 (class 0 OID 16891)
-- Dependencies: 220
-- Data for Name: portfolio_data_issues; Type: TABLE DATA; Schema: data_quality; Owner: postgres
--

COPY data_quality.portfolio_data_issues (id, borrower, facility_name, deal_name, transfers, co_investor, fund, date, segment, balance_gross, principal_additions, process_summary_id) FROM stdin;
1	InsightLend	InsightLend 1	InsightLend 1-7		\N	SIP 2	2019-07-31	Consumer Finance	133333.00000	133333.00000	117
2	GreenEdge	GreenEdge 1	GreenEdge 1-3		\N	SIP 2	2019-07-31	Consumer Finance	2000000.00000	2000000.00000	117
3	InsightLend	InsightLend 1	InsightLend 1-7		\N	SIP 2	2019-08-31	Consumer Finance	133333.00000	0.00000	117
4	GreenEdge	GreenEdge 1	GreenEdge 1-3		\N	CI	2019-08-31	Consumer Finance	2000000.00000	0.00000	117
5	InsightLend	InsightLend 1	InsightLend 1-7		\N	SIP 2	2019-09-30	Consumer Finance	133333.00000	0.00000	117
6	GreenEdge	GreenEdge 1	GreenEdge 1-3		\N	CI	2019-09-30	Consumer Finance	2000000.00000	0.00000	117
7	InsightLend	InsightLend 1	InsightLend 1-7		\N	SIP 2	2019-10-31	Consumer Finance	111111.00000	0.00000	117
8	GreenEdge	GreenEdge 1	GreenEdge 1-3		\N	CI	2019-10-31	Consumer Finance	1666667.00000	0.00000	117
9	InsightLend	InsightLend 1	InsightLend 1-7		\N	SIP 2	2019-11-30	Consumer Finance	111111.00000	0.00000	117
10	GreenEdge	GreenEdge 1	GreenEdge 1-3		\N	CI	2019-11-30	Consumer Finance	1666667.00000	0.00000	117
11	InsightLend	InsightLend 1	InsightLend 1-7		\N	SIP 2	2019-12-31	Consumer Finance	111111.00000	0.00000	117
12	GreenEdge	GreenEdge 1	GreenEdge 1-3		\N	CI	2019-12-31	Consumer Finance	1666667.00000	0.00000	117
13	InsightLend	InsightLend 1	InsightLend 1-7		\N	SIP 2	2020-01-31	Consumer Finance	88889.00000	0.00000	117
14	KopaPay	KopaPay 1	KopaPay 1-4 W	Y	\N	CI	2020-01-31	MSME Finance	293211.00000	293211.00000	117
15	GreenEdge	GreenEdge 1	GreenEdge 1-3		\N	CI	2020-01-31	Consumer Finance	1333333.00000	0.00000	117
16	InsightLend	InsightLend 1	InsightLend 1-7		\N	SIP 2	2020-02-29	Consumer Finance	88889.00000	0.00000	117
17	KopaPay	KopaPay 1	KopaPay 1-4 W		\N	CI	2020-02-29	MSME Finance	293211.00000	0.00000	117
18	KopaPay	KopaPay 1	KopaPay 1-5 W		\N	Flex	2020-02-29	MSME Finance	300000.00000	300000.00000	117
19	GreenEdge	GreenEdge 1	GreenEdge 1-3		\N	CI	2020-02-29	Consumer Finance	1333333.00000	0.00000	117
20	InsightLend	InsightLend 1	InsightLend 1-7		\N	SIP 2	2020-03-31	Consumer Finance	88889.00000	0.00000	117
21	KopaPay	KopaPay 1	KopaPay 1-4 W		\N	CI	2020-03-31	MSME Finance	293211.00000	0.00000	117
22	KopaPay	KopaPay 1	KopaPay 1-5 W		\N	CI	2020-03-31	MSME Finance	300000.00000	0.00000	117
23	GreenEdge	GreenEdge 1	GreenEdge 1-3		\N	CI	2020-03-31	Consumer Finance	1333333.00000	0.00000	117
24	InsightLend	InsightLend 1	InsightLend 1-7		\N	SIP 2	2020-04-30	Consumer Finance	66666.00000	0.00000	117
25	KopaPay	KopaPay 1	KopaPay 1-4 W		\N	CI	2020-04-30	MSME Finance	293211.00000	0.00000	117
26	KopaPay	KopaPay 1	KopaPay 1-5 W		\N	CI	2020-04-30	MSME Finance	300000.00000	0.00000	117
27	KopaPay	KopaPay 1	KopaPay 1-4 W		\N	CI	2020-05-31	MSME Finance	243211.00000	0.00000	117
28	KopaPay	KopaPay 1	KopaPay 1-5 W		\N	CI	2020-05-31	MSME Finance	300000.00000	0.00000	117
29	KopaPay	KopaPay 1	KopaPay 1-4 W		\N	CI	2020-06-30	MSME Finance	0.00000	0.00000	117
30	AutoHoldCo	AutoHoldCo 1	Auto1-10		\N	BOF	2021-08-31	Asset Finance	2193192.00000	617045.00000	117
31	OmniFund	OmniFund 1	OmniFund Group 1-4		\N	RSTCF 1	2021-10-31	Consumer Finance	1544725.00000	1500000.00000	117
32	OrbitFinance	OrbitFinance 1	OrbitFinance 1-7		\N	RSTCF 1	2021-10-31	Asset Finance	1735080.00000	190356.00000	117
33	RocketLend	RocketLend 1	RocketLend 1-4		\N	RSTCF 1	2021-10-31	MSME Finance	1735080.00000	190355.00000	117
34	SwiftPay	SwiftPay 1	SwiftPay 1-5		\N	RSTCF 1	2021-10-31	Payment Platforms	1735080.00000	190355.00000	117
\.


--
-- TOC entry 4970 (class 0 OID 16991)
-- Dependencies: 233
-- Data for Name: process_summaries; Type: TABLE DATA; Schema: data_quality; Owner: postgres
--

COPY data_quality.process_summaries (id, run_date_time, valid_rows, rows_with_issues) FROM stdin;
1	2025-08-23 11:42:08.040793	0	0
2	2025-08-23 11:42:56.331999	0	0
3	2025-08-23 11:43:33.78709	0	0
4	2025-08-23 11:44:49.355448	0	0
5	2025-08-23 11:47:52.276007	0	0
6	2025-08-23 11:49:57.480601	0	0
7	2025-08-23 11:51:33.509674	0	0
8	2025-08-23 11:54:10.615742	0	0
9	2025-08-23 11:58:17.482625	0	0
10	2025-08-23 11:59:05.43188	0	0
11	2025-08-23 12:00:33.299955	0	0
12	2025-08-23 12:01:23.316808	0	0
13	2025-08-23 12:02:01.703258	0	0
14	2025-08-23 12:02:55.445494	0	0
15	2025-08-23 12:04:30.830748	0	0
16	2025-08-23 12:05:47.346876	0	0
17	2025-08-23 12:10:13.748522	0	0
18	2025-08-23 12:19:20.255833	0	0
19	2025-08-23 12:20:00.683429	0	0
20	2025-08-23 12:27:35.573195	0	0
21	2025-08-23 12:28:12.165734	0	0
22	2025-08-23 12:30:50.691324	0	0
23	2025-08-23 12:35:02.893432	0	0
24	2025-08-23 12:37:24.806429	0	0
25	2025-08-23 12:37:59.609679	0	0
26	2025-08-23 12:40:49.861259	0	0
27	2025-08-23 12:43:25.079392	0	0
28	2025-08-23 12:51:28.196434	0	0
29	2025-08-23 12:52:39.393285	0	0
30	2025-08-23 12:58:39.431301	0	0
31	2025-08-23 13:00:27.256285	0	0
32	2025-08-23 13:00:57.674751	0	0
33	2025-08-23 13:04:48.264665	0	0
34	2025-08-23 13:09:05.460549	0	0
35	2025-08-23 13:12:47.053084	0	0
36	2025-08-23 13:15:05.168535	0	0
37	2025-08-23 13:17:02.708547	0	0
38	2025-08-23 13:20:35.474266	0	0
39	2025-08-23 13:24:04.643068	0	0
40	2025-08-23 13:25:47.929595	0	0
41	2025-08-23 13:27:29.687801	0	0
42	2025-08-23 13:28:56.30005	0	0
43	2025-08-23 13:30:30.058707	0	0
44	2025-08-23 13:34:25.041761	0	0
45	2025-08-23 13:36:12.228083	0	0
46	2025-08-24 11:07:12.890811	0	0
47	2025-08-24 11:09:15.669385	0	0
48	2025-08-24 11:14:06.460519	0	0
49	2025-08-24 11:15:47.608093	0	0
50	2025-08-24 11:20:59.280197	0	0
51	2025-08-24 11:24:00.247894	0	0
52	2025-08-24 11:26:07.644767	0	0
53	2025-08-24 11:29:00.728062	0	0
54	2025-08-24 11:32:08.905707	0	0
55	2025-08-24 11:37:08.815329	0	0
56	2025-08-24 11:39:13.792935	0	0
57	2025-08-24 11:40:50.327217	0	0
58	2025-08-24 11:53:08.484493	0	0
59	2025-08-24 12:13:49.212035	0	3802
60	2025-08-24 12:18:50.108095	0	3802
61	2025-08-24 12:23:50.194339	0	3802
62	2025-08-24 12:33:04.743834	0	3802
63	2025-08-24 12:39:43.34593	0	3802
64	2025-08-24 12:54:41.897238	0	3802
65	2025-08-24 13:13:20.579839	0	0
66	2025-08-24 13:23:40.38774	0	3802
67	2025-08-24 13:31:36.992156	0	3802
68	2025-08-24 13:37:01.688208	0	0
69	2025-08-24 13:41:33.683546	0	3802
70	2025-08-24 13:48:57.790602	0	0
71	2025-08-24 13:56:00.466297	0	0
72	2025-08-24 19:35:24.592317	0	0
73	2025-08-24 19:41:34.914701	0	0
74	2025-08-24 19:42:40.721824	0	0
75	2025-08-24 19:47:20.479406	0	0
76	2025-08-24 19:49:18.657673	0	0
77	2025-08-24 19:50:50.810596	0	0
78	2025-08-24 19:51:35.017716	0	0
79	2025-08-24 19:53:02.084595	0	0
80	2025-08-24 19:55:25.948064	0	0
81	2025-08-24 19:58:58.255732	0	0
82	2025-08-24 20:06:35.963267	0	0
83	2025-08-25 11:27:13.737588	0	0
84	2025-08-25 11:45:26.464068	0	0
85	2025-08-25 11:46:46.239105	0	0
86	2025-08-25 11:49:21.340494	0	0
87	2025-08-25 11:57:35.715368	0	0
88	2025-08-25 12:04:22.015885	0	0
89	2025-08-25 12:06:10.903091	0	0
90	2025-08-25 12:28:25.784606	0	0
91	2025-08-25 12:33:08.572546	0	0
92	2025-08-25 12:46:35.75715	0	0
93	2025-08-25 12:54:44.44287	0	0
94	2025-08-25 13:32:43.895073	0	0
95	2025-08-25 13:38:53.73714	0	0
96	2025-08-25 13:45:53.555567	3800	1
97	2025-08-25 13:47:27.961923	3800	1
98	2025-08-25 13:48:56.583733	3800	1
99	2025-08-25 13:58:52.085993	3800	1
100	2025-08-25 14:02:08.985126	3800	1
101	2025-08-25 14:05:22.983286	0	0
102	2025-08-25 14:07:17.492252	0	0
103	2025-08-25 14:12:43.071816	0	0
104	2025-08-25 14:14:52.887435	12033	88
105	2025-08-29 19:59:50.420983	12033	88
106	2025-08-29 20:00:23.87963	12033	88
107	2025-08-31 20:29:28.864718	12033	88
108	2025-08-31 20:31:46.19008	12033	88
109	2025-08-31 20:33:07.096836	12033	88
110	2025-08-31 20:38:05.10761	12033	88
111	2025-09-02 19:32:44.553851	12033	88
112	2025-09-02 19:34:35.027781	12033	88
113	2025-09-02 19:48:31.614674	12033	88
114	2025-09-03 19:43:30.512627	12033	88
115	2025-09-03 19:45:58.716708	12033	88
116	2025-09-03 19:47:54.572842	0	0
117	2025-09-03 19:48:54.164029	12059	62
\.


--
-- TOC entry 4968 (class 0 OID 16954)
-- Dependencies: 225
-- Data for Name: valuation_data_issue_details; Type: TABLE DATA; Schema: data_quality; Owner: postgres
--

COPY data_quality.valuation_data_issue_details (id, valuation_data_issue_id, field_name, description) FROM stdin;
\.


--
-- TOC entry 4966 (class 0 OID 16948)
-- Dependencies: 223
-- Data for Name: valuation_data_issues; Type: TABLE DATA; Schema: data_quality; Owner: postgres
--

COPY data_quality.valuation_data_issues (id, date, rocketlend, omnifund, cargospeed, alphalend, horizoncapital, process_summary_id) FROM stdin;
\.


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 235
-- Name: borrower_data_issue_details_id_seq; Type: SEQUENCE SET; Schema: data_quality; Owner: postgres
--

SELECT pg_catalog.setval('data_quality.borrower_data_issue_details_id_seq', 3104, true);


--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 238
-- Name: coupon_data_issue_details_id_seq; Type: SEQUENCE SET; Schema: data_quality; Owner: postgres
--

SELECT pg_catalog.setval('data_quality.coupon_data_issue_details_id_seq', 37805, true);


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 221
-- Name: portfolio_data_issue_details_id_seq; Type: SEQUENCE SET; Schema: data_quality; Owner: postgres
--

SELECT pg_catalog.setval('data_quality.portfolio_data_issue_details_id_seq', 544, true);


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 232
-- Name: process_summaries_id_seq; Type: SEQUENCE SET; Schema: data_quality; Owner: postgres
--

SELECT pg_catalog.setval('data_quality.process_summaries_id_seq', 117, true);


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 224
-- Name: valuation_data_issue_details_id_seq; Type: SEQUENCE SET; Schema: data_quality; Owner: postgres
--

SELECT pg_catalog.setval('data_quality.valuation_data_issue_details_id_seq', 1, false);


--
-- TOC entry 4799 (class 2606 OID 17002)
-- Name: borrower_data_issues borrower_data_issues_pkey; Type: CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.borrower_data_issues
    ADD CONSTRAINT borrower_data_issues_pkey PRIMARY KEY (id);


--
-- TOC entry 4803 (class 2606 OID 17124)
-- Name: coupon_data_issues coupon_pkey; Type: CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.coupon_data_issues
    ADD CONSTRAINT coupon_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 16895)
-- Name: portfolio_data_issues portfolio_pkey; Type: CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.portfolio_data_issues
    ADD CONSTRAINT portfolio_pkey PRIMARY KEY (id);


--
-- TOC entry 4797 (class 2606 OID 16995)
-- Name: process_summaries process_summaries_pkey; Type: CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.process_summaries
    ADD CONSTRAINT process_summaries_pkey PRIMARY KEY (id);


--
-- TOC entry 4794 (class 2606 OID 16952)
-- Name: valuation_data_issues valuation_data_issues_pkey; Type: CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.valuation_data_issues
    ADD CONSTRAINT valuation_data_issues_pkey PRIMARY KEY (id);


--
-- TOC entry 4801 (class 1259 OID 17012)
-- Name: fki_fk_borrower_data_issue; Type: INDEX; Schema: data_quality; Owner: postgres
--

CREATE INDEX fki_fk_borrower_data_issue ON data_quality.borrower_data_issue_details USING btree (borrower_data_issue_id);


--
-- TOC entry 4800 (class 1259 OID 17033)
-- Name: fki_fk_borrower_di_process_summary; Type: INDEX; Schema: data_quality; Owner: postgres
--

CREATE INDEX fki_fk_borrower_di_process_summary ON data_quality.borrower_data_issues USING btree (process_summary_id);


--
-- TOC entry 4805 (class 1259 OID 17155)
-- Name: fki_fk_coupon_data_issue; Type: INDEX; Schema: data_quality; Owner: postgres
--

CREATE INDEX fki_fk_coupon_data_issue ON data_quality.coupon_data_issue_details USING btree (coupon_data_issue_id);


--
-- TOC entry 4804 (class 1259 OID 17130)
-- Name: fki_fk_coupon_di_process_summary; Type: INDEX; Schema: data_quality; Owner: postgres
--

CREATE INDEX fki_fk_coupon_di_process_summary ON data_quality.coupon_data_issues USING btree (process_summary_id);


--
-- TOC entry 4791 (class 1259 OID 16905)
-- Name: fki_fk_portfolio_data_issue; Type: INDEX; Schema: data_quality; Owner: postgres
--

CREATE INDEX fki_fk_portfolio_data_issue ON data_quality.portfolio_data_issue_details USING btree (portfolio_data_issue_id);


--
-- TOC entry 4788 (class 1259 OID 17045)
-- Name: fki_fk_portfolio_di_process_summary; Type: INDEX; Schema: data_quality; Owner: postgres
--

CREATE INDEX fki_fk_portfolio_di_process_summary ON data_quality.portfolio_data_issues USING btree (process_summary_id);


--
-- TOC entry 4795 (class 1259 OID 16962)
-- Name: fki_fk_valuation_data_issue; Type: INDEX; Schema: data_quality; Owner: postgres
--

CREATE INDEX fki_fk_valuation_data_issue ON data_quality.valuation_data_issue_details USING btree (valuation_data_issue_id);


--
-- TOC entry 4792 (class 1259 OID 17051)
-- Name: fki_fk_valuation_di_process_summary_id; Type: INDEX; Schema: data_quality; Owner: postgres
--

CREATE INDEX fki_fk_valuation_di_process_summary_id ON data_quality.valuation_data_issues USING btree (process_summary_id);


--
-- TOC entry 4811 (class 2606 OID 17007)
-- Name: borrower_data_issue_details fk_borrower_data_issue; Type: FK CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.borrower_data_issue_details
    ADD CONSTRAINT fk_borrower_data_issue FOREIGN KEY (borrower_data_issue_id) REFERENCES data_quality.borrower_data_issues(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4810 (class 2606 OID 17028)
-- Name: borrower_data_issues fk_borrower_di_process_summary; Type: FK CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.borrower_data_issues
    ADD CONSTRAINT fk_borrower_di_process_summary FOREIGN KEY (process_summary_id) REFERENCES data_quality.process_summaries(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4813 (class 2606 OID 17150)
-- Name: coupon_data_issue_details fk_coupon_data_issue; Type: FK CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.coupon_data_issue_details
    ADD CONSTRAINT fk_coupon_data_issue FOREIGN KEY (coupon_data_issue_id) REFERENCES data_quality.coupon_data_issues(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4812 (class 2606 OID 17125)
-- Name: coupon_data_issues fk_coupon_di_process_summary; Type: FK CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.coupon_data_issues
    ADD CONSTRAINT fk_coupon_di_process_summary FOREIGN KEY (process_summary_id) REFERENCES data_quality.process_summaries(id);


--
-- TOC entry 4807 (class 2606 OID 16900)
-- Name: portfolio_data_issue_details fk_portfolio_data_issue; Type: FK CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.portfolio_data_issue_details
    ADD CONSTRAINT fk_portfolio_data_issue FOREIGN KEY (portfolio_data_issue_id) REFERENCES data_quality.portfolio_data_issues(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4806 (class 2606 OID 17040)
-- Name: portfolio_data_issues fk_portfolio_di_process_summary; Type: FK CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.portfolio_data_issues
    ADD CONSTRAINT fk_portfolio_di_process_summary FOREIGN KEY (process_summary_id) REFERENCES data_quality.process_summaries(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4809 (class 2606 OID 16957)
-- Name: valuation_data_issue_details fk_valuation_data_issue; Type: FK CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.valuation_data_issue_details
    ADD CONSTRAINT fk_valuation_data_issue FOREIGN KEY (valuation_data_issue_id) REFERENCES data_quality.valuation_data_issues(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4808 (class 2606 OID 17046)
-- Name: valuation_data_issues fk_valuation_di_process_summary_id; Type: FK CONSTRAINT; Schema: data_quality; Owner: postgres
--

ALTER TABLE ONLY data_quality.valuation_data_issues
    ADD CONSTRAINT fk_valuation_di_process_summary_id FOREIGN KEY (process_summary_id) REFERENCES data_quality.process_summaries(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


-- Completed on 2025-09-06 09:11:17

--
-- PostgreSQL database dump complete
--

\unrestrict aCRcbwVGfc2aj0fpSmhhZGflN5wzDeAol4I5VXg7kEsqrPT46MEOG8l4yKlXi9y

