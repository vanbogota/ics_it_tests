use [ics-it_tests]

if object_id('dbo.TR_Basket_insert_update') is not null
	drop trigger dbo.TR_Basket_insert_update

go

-- Расчет значения скидки, если корзину за раз добавляются 2 и более записей одного продукта
create trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert, update
as
begin
	set nocount on;
	update b
	set b.DiscountValue = case
							when (select count(ID_SKU) from inserted) >= 2
								then b.Value * 0.05
							else 0
						end
	from dbo.Basket as b
		inner join inserted as i on i.ID_identity = b.ID_identity
end