use [ics-it_tests]

if OBJECT_ID('dbo.TR_Basket_insert_update') is not null
drop trigger dbo.TR_Basket_insert_update
go

create trigger dbo.TR_Basket_insert_update
on dbo.Basket
after insert
as
begin
	set nocount on;
	update b
	set DiscountValue = case
							when (select count(ID_SKU) from inserted) >= 2
							then b.Value * 0.05
							else 0
						end
	from dbo.Basket as b
	join inserted as i on b.ID_identity= i.ID_identity
end