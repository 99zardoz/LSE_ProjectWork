The Jupyter notebook contains code to clear down the staging tables, import the data to a staging area, validate the data and produce the base data for the data quality dashboard.  
Finally, it calls a stored procedure sp_reload_warehouse to transform the staging data into a relational snowflake schema.  A set of views is then used to join these tables, producing an identical set
of entities and fields to the Lendable spreadsheet.

The intention is that this proof of concept could be taken forward by the client, replacing the methods that get data from the spreadsheet to obtain it from Lendables' loan management systems.

A backup of the POC database 02092025_LendableDW is included, as is a sql file containing the stored procedure only.
