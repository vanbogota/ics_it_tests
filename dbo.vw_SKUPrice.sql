use [ics-it_tests]

if OBJECT_ID('dbo.vw_SKUPrice') is not null
	drop view dbo.vw_SKUPrice;
go

create view dbo.vw_SKUPrice
as
select 
	ID_identity
	,Code 
	,Name 
	,dbo.udf_GetSKUPrice(ID_identity) as Price
from dbo.SKU

