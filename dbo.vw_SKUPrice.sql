use [ics-it_tests]

if object_id('dbo.vw_SKUPrice') is not null
	drop view dbo.vw_SKUPrice;

go

-- Представление возвращает все атрибуты продуктов из таблицы подуктов и расчетный атрибут со стоимостью одного продукта
create view dbo.vw_SKUPrice
as
select 
	s.ID_identity
	,s.Code 
	,s.Name 
	,dbo.udf_GetSKUPrice(s.ID_identity) as Price
from dbo.SKU as s

