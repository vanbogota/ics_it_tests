use [ics-it_tests]

if object_id('dbo.usp_MakeFamilyPurchase','P') is not null
	drop proc dbo.usp_MakeFamilyPurchase

go

create proc dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as
set nocount on
declare 
	@FamilyID int
	,@FamilyBudget money
	,@TotalValue money

select 
	@FamilyID = f.ID_identity
from dbo.Family as f
where f.SurName = @FamilySurName 

if @FamilyID is null
begin
	print 'Ошибка. Такой семьи нет.'
end

select 
	@FamilyBudget = f.BudgetValue
from dbo.Family as f
where f.ID_identity = @FamilyID;

select 
	@TotalValue = sum(b.Value)
from dbo.Basket as b
where b.ID_Family = @FamilyID;

update dbo.Family
set BudgetValue = @FamilyBudget - @TotalValue
where ID_identity = @FamilyID

