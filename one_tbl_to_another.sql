-- copy one table to another across databases
-- copy everything from db2 to db1

use db1;
go

insert into dbo.tbl_name
select *
from db2.dbo.tbl_name;
go
