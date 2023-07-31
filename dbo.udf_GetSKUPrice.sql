use [ics-it_tests]

if object_id('dbo.udf_GetSKUPrice') is not null 
	drop function dbo.udf_GetSKUPrice

go

-- Функция для расчета стоимости одного продукта
create function dbo.udf_GetSKUPrice (@ID_SKU int)
returns decimal(18, 2)
as
begin
declare 
	@Price decimal(18, 2)
select 
	@Price = cast(sum(b.Value) as decimal(18, 2))/cast(sum(b.Quantity) as decimal(18,2))
from dbo.Basket as b
where b.ID_SKU = @ID_SKU

return 
	@Price
end