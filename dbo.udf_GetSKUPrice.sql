USE [ics-it_tests]

IF OBJECT_ID('dbo.udf_GetSKUPrice') IS NOT NULL DROP FUNCTION dbo.udf_GetSKUPrice;
GO

CREATE FUNCTION dbo.udf_GetSKUPrice(@ID_SKU INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
	DECLARE @price DECIMAL(18, 2);
	SELECT @price = CAST(SUM(b.Value) as decimal(18, 2))/CAST(SUM(b.Quantity) as decimal(18,2))
	FROM dbo.Basket b
	WHERE b.ID_SKU = @ID_SKU;
	RETURN @price;
END;