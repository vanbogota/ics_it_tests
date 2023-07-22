use [ics-it_tests];

if OBJECT_ID('dbo.Basket', 'U') is not null
drop table dbo.Basket;

if OBJECT_ID('dbo.SKU', 'U') is not null
drop table dbo.SKU;

if OBJECT_ID('dbo.Family', 'U') is not null
drop table dbo.Family;

create table dbo.SKU
(
ID_identity int,
Code AS 's' + ID_identity
	constraint AK_Code unique(Code),
Name varchar not null,
constraint PK_SKU
	primary key(ID_identity)
);

create table dbo.Family
(
ID_identity int,
SurName varchar not null,
BudgetValue money,
constraint PK_Family
	primary key(ID_identity)
);

create table dbo.Basket
(
ID_identity int,
ID_SKU int 
	constraint FK_Basket_SKU
	foreign key(ID_identity)
	references dbo.SKU(ID_identity),
ID_Family int 
	constraint FK_Basket_Family
	foreign key(ID_identity)
	references dbo.Family(ID_identity),
Quantity int 
	constraint CHK_Basket_Quantity
	check (Quantity > 0),
Value int 
	constraint CHK_Basket_Value
	check (Value > 0),
PurchaseDate datetime 
	constraint DFT_Basket_PurchaseDate
	default(SYSDATETIME()) for PurchaseDate,
DiscountValue numeric,
constraint PK_Basket
	primary key(ID_identity)
);
