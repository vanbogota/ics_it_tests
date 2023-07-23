USE [ics-it_tests]

IF OBJECT_ID('dbo.usp_MakeFamilyPurchase','P') IS NOT NULL
DROP PROC dbo.usp_MakeFamilyPurchase;
GO

CREATE PROC dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
AS
BEGIN

DECLARE @FamilyID INT

SELECT @FamilyID = ID_identity
FROM dbo.Family
WHERE SurName = @FamilySurName 

IF @FamilyID IS NULL
BEGIN
 PRINT N'Ошибка. Такой семьи нет.';
END

DECLARE @FamilyBudget MONEY
DECLARE @TotalValue MONEY

SELECT @FamilyBudget = BudgetValue
FROM dbo.Family
WHERE ID_identity = @FamilyID;

SELECT @TotalValue = SUM(Value)
FROM dbo.Basket
WHERE ID_Family = @FamilyID;

UPDATE dbo.Family
SET BudgetValue = @FamilyBudget - @TotalValue
WHERE ID_identity = @FamilyID

END
GO