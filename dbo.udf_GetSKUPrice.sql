use [ics-it_tests]

if OBJECT_ID('dbo.udf_GetSKUPrice') is not null 
	drop function dbo.udf_GetSKUPrice;
go

create function dbo.udf_GetSKUPrice(@ID_SKU int)
returns decimal(18, 2)
as
begin
	declare 
		@price decimal(18, 2);
	select 
		@price = CAST(SUM(b.Value) as decimal(18, 2))/CAST(SUM(b.Quantity) as decimal(18,2))
	from dbo.Basket b
	where b.ID_SKU = @ID_SKU;
	return @price;
end;