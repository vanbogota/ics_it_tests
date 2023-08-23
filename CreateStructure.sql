-- Создание исходных таблиц
use [ics-it_tests];

if object_id('dbo.Basket', 'U') is not null
	drop table dbo.Basket;

if object_id('dbo.SKU', 'U') is not null
	drop table dbo.SKU;

if object_id('dbo.Family', 'U') is not null
	drop table dbo.Family;

create table dbo.SKU (
	ID_identity int not null identity,
	Code as 's' + cast(ID_identity as varchar),
	Name varchar(1000) not null,
	constraint UK_SKU_Code unique (Code),
	constraint PK_SKU primary key (ID_identity)
)

create table dbo.Family (
	ID_identity int not null identity,
	SurName varchar(max) not null,
	BudgetValue money not null,
	constraint PK_Family primary key (ID_identity)
)

create table dbo.Basket(
	ID_identity int not null identity,
	ID_SKU int not null,	
	ID_Family int not null,
	Quantity int not null,
	Value money not null,
	DatePurchase datetime default(sysdatetime()),
	DiscountValue numeric(18,2),
	constraint PK_Basket primary key (ID_identity),
	constraint FK_Basket_ID_SKU_SKU foreign key (ID_SKU) references dbo.SKU(ID_identity),
	constraint FK_Basket_ID_Family_Family foreign key (ID_Family) references dbo.Family(ID_identity),
	constraint CK_Basket_Quantity check (Quantity > 0),
	constraint CK_Basket_Value check (Value > 0)
)
