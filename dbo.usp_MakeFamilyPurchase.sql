use [ics-it_tests]

if OBJECT_ID('dbo.usp_MakeFamilyPurchase','P') is not null
	drop proc dbo.usp_MakeFamilyPurchase;
go

create proc dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as
begin
	set nocount on

	declare 
		@FamilyID int

	select 
		@FamilyID = ID_identity
	from dbo.Family
	where SurName = @FamilySurName 

	if @FamilyID is null
		begin
			print N'Ошибка. Такой семьи нет.';
		end

	declare 
		@FamilyBudget money
	declare
		@TotalValue money

	select 
		@FamilyBudget = BudgetValue
	from dbo.Family
	where ID_identity = @FamilyID;

	select 
		@TotalValue = sum(Value)
	from dbo.Basket
	where ID_Family = @FamilyID;

	update dbo.Family
	set BudgetValue = @FamilyBudget - @TotalValue
	where ID_identity = @FamilyID
end
