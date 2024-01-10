-- bulk insert script

use [xxx];
go

bulk insert bulk_insert
       from 'C:\Users\xxx\Desktop\SQL\BULK INSERT\file_source\test.csv'
       with (
              FORMAT = 'CSV',
              FIELDTERMINATOR = ',',
              ROWTERMINATOR = '0x0a');
go

----

-- more detailed script

BEGIN TRANSACTION;

USE [xxx];
go

DROP TABLE IF EXISTS tbl_name;
go

CREATE TABLE tbl_name (
	column1 vacrhar(max) null,
	column2 varchar(max) null,
	...);
go

BULK INSERT tbl_name
	FROM 'c:\users\user_name\desktop\folder\flatfile.tsv,csv...
	WITH (
	DATAFILETYPE = 'char',
	FIRSTROW = 2,
	FIELDTERMINATOR = '\t' or ',' ...,
	ROWTERMINATOR = 0x0a',
	BATCHSIZE = 2000000 -- optional,
	KEEPNULLS);
go

	--UPDATE existing table with diferent data types, from varchar(max) to int,char, decimal...--

	--CREATE new table with exactly specified data types, same as for above changes--

	--if new column is going to have identity(1,1) primary key then:--

SET IDENTITY_newtablename ON;
go

INSERT INTO newtablename (column1, column2...)
	SELECT column1, column2...
	FROM oldtablename;
go

SET IDENTITY_newtablename OFF;
go

DROP TABLE IF EXISTS oldtablename;
go

ROLLBACK TRANSACTION;
