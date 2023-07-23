USE [ics-it_tests];

IF OBJECT_ID('dbo.Basket', 'U') IS NOT NULL
DROP TABLE dbo.Basket;

IF OBJECT_ID('dbo.SKU', 'U') IS NOT NULL
DROP TABLE dbo.SKU;

IF OBJECT_ID('dbo.Family', 'U') IS NOT NULL
DROP TABLE dbo.Family;

CREATE TABLE dbo.SKU
(
 ID_identity INT IDENTITY(1,1),
 Code AS 's' + CAST(ID_identity AS VARCHAR),
 Name VARCHAR(max) NOT NULL,
 CONSTRAINT AK_Code UNIQUE(Code),
 CONSTRAINT PK_SKU PRIMARY KEY(ID_identity)
);

CREATE TABLE dbo.Family
(
 ID_identity INT IDENTITY(1,1),
 SurName VARCHAR(max) NOT NULL,
 BudgetValue MONEY,
 CONSTRAINT PK_Family PRIMARY KEY(ID_identity)
);

CREATE TABLE dbo.Basket
(
 ID_identity INT IDENTITY(1,1),
 ID_SKU INT,	
 ID_Family INT,
 Quantity INT 
	CONSTRAINT CHK_Basket_Quantity
	CHECK (Quantity > 0),
 Value INT 
	CONSTRAINT CHK_Basket_Value
	CHECK (Value > 0),
 PurchaseDate DATETIME DEFAULT(SYSDATETIME()),
 DiscountValue NUMERIC(18,5),
 CONSTRAINT FK_Basket_SKU 
	FOREIGN KEY(ID_SKU)
	REFERENCES dbo.SKU(ID_identity),
 CONSTRAINT FK_Basket_Family
	FOREIGN KEY(ID_Family)
	REFERENCES dbo.Family(ID_identity),
 CONSTRAINT PK_Basket PRIMARY KEY(ID_identity)
);
