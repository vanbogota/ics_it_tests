use [ics-it_tests]

IF OBJECT_ID('dbo.vw_SKUPrice') IS NOT NULL
DROP VIEW dbo.vw_SKUPrice;
GO

CREATE VIEW dbo.vw_SKUPrice
AS
SELECT ID_identity, Code, Name, dbo.udf_GetSKUPrice(ID_identity) AS Price
FROM dbo.SKU

