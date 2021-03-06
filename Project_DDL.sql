-------==================================
--Drop with (If condition) Database Inventory Management System
-------==================================
Use Master
IF DB_ID  ('InventoryProject_DB') IS NOT NULL
DROP Database InventoryProject_DB
GO
-------==================================
--Create Database Inventory Management System
-------==================================
Create Database InventoryProject_DB
GO

-------==================================
--Drop Database Inventory Management System
-------==================================
--Use Master 
--Drop Database InventoryProject_DB
--GO
-------==================================
--Create Schema
-------==================================
Use InventoryProject_DB
GO
CREATE SCHEMA store
GO
-------==================================
--Create Table: Product
-------==================================
Use InventoryProject_DB
Create Table store.Product
(
	ProductID int Primary Key identity,
	ProductName varchar(30) Not Null,
	ProductSize varchar(5) Not Null,
	ProductCode nvarchar(10) Not Null,
	ProductQuantity varchar(10) Not Null,
	PoductPrice Money Not Null,
	ProductTotal as (ProductQuantity*PoductPrice)
)
GO

-------==================================
--Create Table: Category
-------==================================
Use InventoryProject_DB
Create Table store.Category
(
	CategoryID int Primary Key identity,
	CategoryName varchar(30) Not Null,
	ProductID int Foreign Key References store.Product(ProductID)ON UPDATE CASCADE
)
GO

-------==================================
--Create Table: Stock
-------==================================
Use InventoryProject_DB
Create Table store.Stock
(
	StocktID int Primary Key identity,
	StockName varchar(30) Not Null,
	Company varchar(30) Sparse,
	CompanyAddress nvarchar(10) Not Null,
	CompanyPhone char(15) Not Null Check((CompanyPhone like'[+][8][8][0][1][1-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9][0-9]')),
	DateInSystem Datetime Not Null Constraint Cn_CustomerDafaultDateInSystem Default (Getdate()) Check ((DateInSystem<=Getdate())),
	ProductID int Foreign Key References store.Product(ProductID)
)
GO

-------==================================
--Create Table: Suplier
-------==================================
Use InventoryProject_DB
Create Table store.Supplier
(
	SupplierID INT PRIMARY KEY IDENTITY,
	SupplierName VARCHAR (50) NOT NULL,
	ContactPersonName VARCHAR (30) NOT NULL,
	Email VARCHAR(40) NULL,
	Contact VARCHAR (15) NOT NULL,
	City VARCHAR (20) NULL,
	[State] VARCHAR (20) NULL,
	Country VARCHAR (20) NULL,
	IsActive BIT DEFAULT 0,
	SupplierPhone char(15) Not Null CHECK (SupplierPhone LIKE '[+][8][8][0][1][1-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO

-------==================================
--Create Table: Purchase
-------==================================
Use InventoryProject_DB
Create Table store.Purchase
(
	PurchaseID int Primary Key identity,
	PurchaseDate Date Default (Getdate()),
	PurchaseQuantity varchar(10) Not Null,
	PurchasePrice Money Not Null,
	PurchaseTotal as (PurchaseQuantity*PurchasePrice),
	ProductID int Foreign Key References store.Product (ProductID),
	SupplierID int Foreign Key References store.Supplier(SupplierID)ON DELETE CASCADE
)
GO


-------==================================
--Create Table: Customers
-------==================================
Use InventoryProject_DB
Create Table store.Customers
(
	CustomerID INT PRIMARY KEY IDENTITY,
	CustomerName VARCHAR (50) NOT NULL,
	CustomersEmail VARCHAR(40) NULL,
	CustomersContact VARCHAR (15) NOT NULL,
	CustomersCity VARCHAR (20) NULL,
	CustomersIsActive BIT DEFAULT 0,
	CustomersMobile char(15) Not Null CHECK (CustomersMobile LIKE '[+][8][8][0][1][1-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9][0-9]'),
	ProductID int Foreign Key References store.Product (ProductID)
)
GO

-------==================================
--Create Table: Order
-------==================================
Use InventoryProject_DB
CREATE TABLE store.[Order]
(
	OrderID INT IDENTITY PRIMARY KEY,
	OrderType VARCHAR (30) NOT NULL,
	[Date] DATE,
	Rate MONEY NOT NULL,
	Quantity INT NOT NULL,
	GrossAmount as (Rate*Quantity),
	Discount MONEY NULL,
	Vat MONEY NULL,
	NetAmount as (((Quantity*Rate)+(Quantity*Rate)*vat)),
	CustomerID int Foreign Key References store.Customers(CustomerID)
)
GO

-------==================================
--Create Table: OrderDtails
-------==================================
Use InventoryProject_DB
CREATE TABLE store.OrderDetails
(
	OrderID INT IDENTITY PRIMARY KEY,
	OrderType VARCHAR (30) NOT NULL,
	[Date] DATE,
	Rate MONEY NOT NULL,
	Quantity INT NOT NULL,
	GrossAmount as (Rate*Quantity),
	Discount MONEY NULL,
	Vat MONEY NULL,
	NetAmount as (((Quantity*Rate)+(Quantity*Rate)*vat)),
	OrderDetails varchar(20) Null,
	CustomerID int Foreign Key References store.Customers(CustomerID)
)
GO

-------==================================
--Create Table: Employee
-------==================================
Use InventoryProject_DB
Create Table store.Employee
(
	EmployeeID INT PRIMARY KEY IDENTITY,
	EmployeeName VARCHAR (50) NOT NULL,
	Desingration VARCHAR (30) NOT NULL,
	Email VARCHAR(40) NULL,
	Contact VARCHAR (15) NOT NULL,
	IsActive BIT DEFAULT 0,
	EmployeePhone char(15) Not Null CHECK (EmployeePhone LIKE '[+][8][8][0][1][1-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CustomersID int Foreign Key References store.Customers (CustomerID)
)
GO

-------==================================
--Create Table: Office
-------==================================
Use InventoryProject_DB
Create Table Office
(
	OfficeID int identity(1,1) Not Null,
	FormattedOfficeID as ('Foysal' + Left('Ctg' + Cast(OfficeID as varchar(10)),15)),
	OfficeName varchar(30),
	OfficeCode nvarchar(10),
	Constraint PK_Office Primary Key(OfficeID,OfficeCode),
	EmployeeID int Foreign Key References store.Employee (EmployeeID)
)
GO

-------==================================
--Create Table: Sales
-------==================================
Use InventoryProject_DB
CREATE TABLE store.Sales
(
	SalesID INT IDENTITY PRIMARY KEY,
	SalesRate MONEY NOT NULL,
	SalesQuantity INT NOT NULL,
	Vat MONEY NULL,
	NetAmount as (((SalesQuantity*SalesRate)+(SalesQuantity*SalesRate)*vat)),
	EmployeeID int Foreign Key References store.Employee (EmployeeID)
)
GO

-------==================================
--Truncate Table
-------==================================
Truncate Table store.Product
Truncate Table store.Customer
Go

-------==================================
--Create Trigger for Insert Table: store.Order
-------==================================
Create Trigger Tr_Order ON dbo.store.[Order]
For Insert
As
Declare @orderid int, @ordertype varchar(30), @date date, @rate money, @quantity int, @discound money, @orderdtails varchar(20), @customerid int
Select @orderid=i.OrderID From inserted i;
Select @ordertype=i.OrderType From inserted i; 
Select @date=i.[Date] From inserted i; 
Select @rate=i.Rate From inserted i;
Select @quantity=i.Quantity From inserted i; 
Select @discound=i.Discount From inserted i; 
Select @customerid=i.CustomerID From inserted i;
Set @orderdtails='Inserted Record_After Insert Trigger'
Insert into OrderDetails(OrderID,OrderType,Date,Rate,Quantity,Discount,OrderDetails,CustomerID)
Values (@orderid,@ordertype,@date,@rate,@quantity,@discound,@orderdtails,@customerid);
Print 'After insert Trigger Fired'
GO

-------==================================
--Create Trigger for Insted Update and Delete Table: store.Order
-------==================================
Create Trigger trg_UpdateDelete on store.Product
Instead of Update, Delete
AS
Declare @rowcount int
Set @rowcount=@@ROWCOUNT
IF(@rowcount>1)
				BEGIN
				Raiserror('You cannot Update or Delete more than 1 Record',16,1)
				END
Else 
	Print 'Update or Delete Successful'
GO
-------==================================
--Insert Trigger for Table: store.Order
-------==================================
Insert into store.[Order](OrderType,Date,Rate,Quantity,Discount,CustomerID) values('Inventory','',20,25,5,1),('Inventory','',20,250,5,1),('Inventory','',200,25,5,1);
GO


-------==================================
--Create Tabular and Scalar Function
-------==================================
--Create Tabular Function
Create Function fn_Tabular(@productsize varchar(20))
Returns Table
AS
Return
(
Select p.ProductID,ProductCode,ProductName,c.CategoryID,CategoryName
From store.Product as p
Join store.Category as c
On p.ProductID= c.ProductID
Where ProductSize = @productsize
)
GO

--OutPut
Select * from dbo.fn_Tabular('L')
GO

--Create Scalar Function
Create Function fn_Scalar(@producttotal int)
Returns int
AS
Begin
	Return
	(
	Select sum(ProductTotal) as [Total amount]
	From store.Product as p
	)
End
GO

--OutPut
Print dbo.fn_Scalar(10)
GO

-------==================================
----Create Schemabinding
-------==================================
Create View vw_Schema
With Schemabinding
AS
Select *
From store.Product as p join store.Stock as s
On p.ProductID=s.ProductID
Go
-------==================================
----Create View vw_Product Table
-------==================================
Create View vw_Product
As
Select ProductID, ProductName, ProductCode, ProductQuantity, ProductSize
From store.Product
Where ProductName Like 'Pol%'
Or ProductName Like 'T-___rt%'
With Check Option;
GO

Select * From vw_Product


--Update vw_CustomersCheck
Update vw_Product
Set ProductName='T-Shirt'
Where ProductCode=2;
GO

-------==================================
-- Alter and Drop Table
-------==================================
Alter Table Office
Add Address varchar(20)
GO

Alter Table Office
Drop Column Address
GO
-------==================================
-- Create Procedures and Alter
-------==================================
Create Proc sp_Employee_Sales
	@employeeid INT,
	@employeename VARCHAR (50),
	@desingration VARCHAR (30),
	@email VARCHAR(40),
	@contact VARCHAR (15),
	@isactive BIT,
	@employeephone char(15),
	@customersid int,
	@salesid INT,
	@salesrate MONEY,
	@salesquantity INT,
	@vat MONEY,
	@tablename varchar(20),
	@operationname varchar(25)
As
Begin
	If(@tablename= 'store.Employee' and @operationname= 'Insert')
	Begin
		Insert store.Employee values (@employeename, @desingration,@email,@contact,@isactive,@employeephone,@customersid)
	End
	If(@tablename= 'store.Employee' and @operationname= 'Update')
	Begin
		Update store.Employee Set EmployeeName=@employeename Where EmployeeID=@employeeid
	End
	If(@tablename= 'store.Employee' and @operationname= 'Delete')
	Begin
		Delete From store.Employee Where EmployeeID=@employeeid
	End



	If(@tablename= 'store.Sales' and @operationname= 'Insert')
	Begin
		Insert store.Sales values (@salesrate,@salesquantity,@vat)
	End
	If(@tablename= 'store.Sales' and @operationname= 'Update')
	Begin
		Update store.Sales Set SalesRate=@salesrate Where SalesID=@salesid
	End
	If(@tablename= 'store.Sales' and @operationname= 'Delete')
	Begin
		Delete From store.Sales Where SalesID=@salesid
	End
End
GO


Exec sp_Employee_Sales 1,'Tusar','Manager','tusar@gmail.com','Chittagong',1,'+8801813-148110',2,'store.Product','Insert'
GO


-------==================================
-- Create Procedures For Office: Try, Begin Tran, Commit, Catch, Rollback Tran, Print
-------==================================
Create proc sp_Office
@officeid int ,
@formattedofficeid varchar(30),
@officename varchar(30),
@officecode nvarchar(10),
@employeeid int,
@message varchar(30) output	 -- For Message Passing
as
	Begin
		Begin Try
			Begin Tran
				Insert Office(OfficeID,FormattedOfficeID,OfficeName,OfficeCode,EmployeeID)
				Values(@officeid,@formattedofficeid,@officename,@officecode,@employeeid)
				Set @message='Data Inserted Completed'
				Print @message
			Commit Tran
		End Try
		Begin Catch
			Rollback Tran
			Print 'Something Was Wrong!!!'
		End Catch
	End
GO
--Insereted
Declare @ar varchar(30)
exec sp_Office 1,'07','Arefin','101',1,@ar output
GO

-------==================================
-- With Loop, If, Else and While
-------==================================
Use InventoryProject_DB
Declare @i int=0;
While @i <10
Begin
	If @i%2=0
		Begin
			Print @i
		End
	Else
		Begin
			Print Cast(@i as varchar) + 'Skip'
		End
	Set @i=@i+1-1*2/2
End
GO

-------==================================
-- With Loop, If, Else and While
-------==================================
Declare @i int=0;
While @i <10
Begin
	If @i%2=0
		Begin
			Print @i
		End
	Else
		Begin
			Print Cast(@i as varchar) + 'Skip'
		End
	Set @i=@i+1-1*2/2
End
GO

-------==================================
--Create Clustered And Non Clustered
-------==================================
Create Clustered Index Cl_Index On dbo.#tampTable(Roll)
GO

Create Index NCL_Index On dbo.#tampTable(Class)
GO

-------==================================
--Floor Round DatedIF Function
-------==================================
Declare @x money =12.49;
Select FLOOR(@x) As FloorRuselt, ROUND(@x,0) as RoundRuselt

Select DATEDIFF(yy,CAST('10/12/1990' as datetime), GETDATE ()) As Years,
	   DATEDIFF(MM,CAST('10/12/1990' as datetime), GETDATE ())%12 As Months,
	   DATEDIFF(DD,CAST('10/12/1990' as datetime), GETDATE ())%30 As Days
GO

Select Getdate() AS Moin_Sir

Declare @value decimal(10,2)=11.05
Select ROUND(@value,1)
Select Ceiling(@value)
Select Floor(@value)
GO





