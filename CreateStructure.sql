use [ics-it_tests];

if OBJECT_ID('dbo.Basket', 'U') is not null
	drop table dbo.Basket;

if OBJECT_ID('dbo.SKU', 'U') is not null
	drop table dbo.SKU;

if OBJECT_ID('dbo.Family', 'U') is not null
	drop table dbo.Family;

create table dbo.SKU
(
 ID_identity int identity(1,1),
 Code as 's' + CAST(ID_identity as varchar),
 Name varchar(max) not null,
 constraint AK_Code unique(Code),
 constraint PK_SKU primary key(ID_identity)
);

create table dbo.Family
(
 ID_identity int identity(1,1),
 SurName varchar(max) not null,
 BudgetValue money,
 constraint PK_Family primary key(ID_identity)
);

create table dbo.Basket
(
 ID_identity int identity(1,1),
 ID_SKU int,	
 ID_Family int,
 Quantity int 
	constraint CHK_Basket_Quantity
	check (Quantity > 0),
 Value money 
	constraint CHK_Basket_Value
	check (Value > 0),
 PurchaseDate datetime default(SYSDATETIME()),
 DiscountValue numeric(18,2),
 constraint FK_Basket_SKU 
	foreign key(ID_SKU)
	references dbo.SKU(ID_identity),
 constraint FK_Basket_Family
	foreign key(ID_Family)
	references dbo.Family(ID_identity),
 constraint PK_Basket 
	primary key(ID_identity)
);
