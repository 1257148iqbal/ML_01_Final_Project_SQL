
Use InventoryProject_DB
GO
-------==================================
--Value Insert Table: store.Product
-------==================================
Insert Into store.Product (	ProductName,ProductSize,ProductCode,ProductQuantity,PoductPrice)
Values ('T-Shirt','M',11,50,10),
		('Polo Shirt','L',11,60,10),
		('Max Shirt','L',15,70,10),
		('Data Shirt','M',15,90,10),
		('Jeans Pants','M',15,50,10),
		('Thai Jeans Pants','S',10,50,10),
		('T-Shirt','S',10,50,10);
Go

-------==================================
--Value Insert Table: store.Category
-------==================================
Insert Into store.Category (CategoryName,ProductID)
Values ('Shirt',1),('Shirt',1),('Shirt',2),('Shirt',2),('Shirt',1),('Jeans',6),('Jeans',6),('Shirt',1),('Shirt',7);
GO

-------==================================
--Value Insert Table: store.Stock
-------==================================
Insert Into store.Stock (StockName,Company,CompanyAddress,CompanyPhone,DateInSystem,ProductID)
						Values ('Shirt','Clipton Group','Chittagong','+8801813-148110','10/16/2018', 2),
								('Shirt','Clipton Group','Chittagong','+8801813-148110',Getdate(), 2),
								('Shirt','Clipton Group','Chittagong','+8801813-148110',Getdate(), 2),
								('Jeans','Youngone','Dhaka','+8801813-148110',Getdate(), 7),
								('Jeans','Youngone','Dhaka','+8801813-148110',Getdate(), 7),
								('Jeans','Youngone','Dhaka','+8801813-148110',Getdate(), 7),
								('Shirt','Mam Gropu','Chittagong','+8801813-148110',Getdate(), 4),
								('Shirt','Shamim Group','Rangpur','+8801813-148110',Getdate(), 4);
Go

-------==================================
--Value Insert Table: store.Supplier
-------==================================
Insert Into store.Supplier (SupplierName,ContactPersonName,Email,Contact,City,[State],Country,IsActive,SupplierPhone)
						Values ('Md. Rahim','Mr. Karim','rahim@gmail.com','Dhaka','Dhaka','Dhaka','Bangladesh',1, '+8801813-148110'),
						 ('Md. Salam','Mr. Sharif','rahim@gmail.com','Dhaka','Dhaka','Dhaka','Bangladesh', 1,'+8801813-148110'),
						 ('Md. Faruk','Mr. Hamid','rahim@gmail.com','Chittagong','Dhaka','Dhaka','Bangladesh',1, '+8801813-148110'),
						 ('Md. Amjad','Mr. Younus','rahim@gmail.com','Sham','Velgiam','Velgiam','Chin', 1,'+8801813-148110'),
						 ('Md. Foysal','Mr. Wahid','rahim@gmail.com','Gain','Hamida','Hamida','Turky', 0,'+8801813-148110'),
						 ('Md. Jahid','Mr. Ashraf','rahim@gmail.com','Dhaka','Dhaka','Dhaka','Bangladesh',1, '+8801813-148110'),
						 ('Md. Rahim','Mr. Moin','rahim@gmail.com','Dhaka','Dhaka','Dhaka','Bangladesh',1, '+8801813-148110'),
						 ('Md. Rahim','Mr. Arefin','rahim@gmail.com','Vargin','Rohingga','Rohingga','Mayenmar',1, '+8801813-148110');
Go

-------==================================
--Value Insert Table: store.Purchase
-------==================================
Insert Into store.Purchase values('10/16/2019',10,15,1,1), ('10/16/2019',10,15,1,2), ('10/16/2019',10,15,2,1), ('10/16/2019',10,15,3,2), ('10/16/2019',10,15,3,3), ('10/16/2019',10,15,3,4), ('10/16/2019',10,15,4,5), ('10/16/2019',10,15,6,6);
GO

-------==================================
--Value Insert Table: store.Customers
-------==================================
Insert Into store.Customers (CustomerName,CustomersEmail,CustomersContact,CustomersCity,CustomersIsActive,CustomersMobile,ProductID)
Values ('Arif','mmm@gmail.com','Dhaka','Dhaka',1,'+8801813-148110',1),
('Rifat','mmm@gmail.com','Dhaka','Dhaka',1,'+8801813-148110',2),
('Halim','mmm@gmail.com','Dhaka','Dhaka',1,'+8801813-148110',3),
('Sultan','mmm@gmail.com','Dhaka','Dhaka',1,'+8801813-148110',4),
('Shahin','mmm@gmail.com','Dhaka','Dhaka',1,'+8801813-148110',5),
('Mustak','mmm@gmail.com','Dhaka','Dhaka',0,'+8801813-148110',6),
('Moin','mmm@gmail.com','Dhaka','Dhaka',1,'+8801813-148110',7);
GO

-------==================================
--Between, All, Any, And, Or, Not
-------==================================
SELECT * FROM store.Stock
WHERE (StockName = 'Shirt' AND StocktID <> 20)
OR (StocktID = 100);
SELECT * FROM store.Stock
Where StockName NOT IN ('Jeans') 
SELECT * FROM store.Stock
WHERE StocktID BETWEEN 2 AND 4;
SELECT * FROM store.Product
WHERE ProductTotal > ANY (Select ProductTotal From store.Product Where ProductID>2);
SELECT * FROM store.Product
WHERE ProductTotal > ALL (Select ProductTotal From store.Product Where ProductID>2);

-------==================================
--Join: Inner, Outer(Left, Right), Full, Self, cross/
--Union, All Union, Intersection
-------==================================
--Inner Join
Select p.ProductID, ProductName, ProductCode, CategoryName, PurchaseID, PurchasePrice, PurchaseQuantity, StockName
From store.Product as p
Inner Join store.Category as c
ON p.ProductID=c.CategoryID
Join store.Purchase as u
ON u.ProductID=p.ProductID
join store.Stock as s
ON s.ProductID=p.ProductID

--Left Outer Join
Select p.ProductID, ProductName, ProductCode, CategoryName, PurchaseID, PurchasePrice, PurchaseQuantity, StockName
From store.Product as p
Left Join store.Category as c
ON p.ProductID=c.CategoryID
Join store.Purchase as u
ON u.ProductID=p.ProductID
join store.Stock as s
ON s.ProductID=p.ProductID

--Right outer Join
Select p.ProductID, ProductName, ProductCode, CategoryName, PurchaseID, PurchasePrice, PurchaseQuantity, StockName
From store.Product as p
Right Join store.Category as c
ON p.ProductID=c.CategoryID
Join store.Purchase as u
ON u.ProductID=p.ProductID
Left join store.Stock as s
ON s.ProductID=p.ProductID

--Full Join
Select p.ProductID, ProductName, ProductCode, CategoryName, PurchaseID, PurchasePrice, PurchaseQuantity, StockName
From store.Product as p
Inner Join store.Category as c
ON p.ProductID=c.CategoryID
Full Join store.Purchase as u
ON u.ProductID=p.ProductID
join store.Stock as s
ON s.ProductID=p.ProductID

--Cross Join
Select p.ProductID, ProductName, ProductCode, CategoryName
From store.Product as p
Cross Join store.Category as c

--Self Join
Select p.ProductID, c.ProductName, p.ProductCode
From store.Product as p, store.Product as c
Where p.ProductID <> c.ProductID


-- Union Operator 
Select ProductID From store.Product
Union 
Select CategoryID From store.Category
GO


-- Union All Operator 
Select ProductID From store.Product
Union 
Select CategoryID From store.Category
GO

--Intersection Operator
Select ProductID From store.Product
Interrsection
Select CategoryID From store.Category
GO


--=====================
--All Clauses: Select, From, Where, Group By, Having, OrderBY
--====================

--Order by
Select ProductSize,count(ProductID) as p
From store.Product
Where ProductSize='M'
Group By ProductSize
Having Count(ProductSize)<4
--Order BY ASEC
GO


-------==================================
--Update Trigger Table: store.Order
-------==================================
Update store.[Order]
Set OrderType='Wahid'
Where OrderID=2
GO

-------==================================
--Delate Trigger Table: store.Order
-------==================================
Delete store.[Order]
Where OrderID=2
GO

-------==================================
--Select Queary
-------==================================
Select * From store.Product
Select * From store.Category
Select * From store.Stock
Select * From store.Supplier
Select * From store.Purchase
Select * From store.Customers
Select * From store.[Order]
Select * From store.OrderDetails
Select * From store.Employee
Select * From Office
Select * From store.Sales


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

--=====================================
--Cube, Rollup, Compute, Computeby, Grouping
--=====================================

Select 'A' [Class], 1 [Roll], 'a' [Section], 80 [Marks], 'Moin' [StuName]
into #tampTable
Union
Select 'A', 2, 'a', 70, 'Rasel'
Union
Select 'A', 3, 'a', 80, 'Arifin'
Union
Select 'A', 4, 'b', 90, 'Elias'
Union
Select 'A', 5, 'b', 90, 'Alamgir'
Union
Select 'A', 6, 'b', 50, 'Iqbal'
Union
Select 'B', 1, 'a', 60, 'You'
Union
Select 'B', 2, 'a', 50, 'Mizan'
Union
Select 'B', 3, 'a', 80, 'Sayed'
Union
Select 'B', 4, 'b', 90, 'Ashraf'
Union
Select 'B', 5, 'b', 50, 'Hasan'
Union
Select 'B', 6, 'b', 70, 'Mahbub'
GO


Select * From #tampTable
GO


--Rollup
Select Class, Section, Sum(Marks) As [Sum]
From #tampTable
Group By Class, Section With Rollup
GO

--Cube
Select Class, Section, Sum(Marks) AS [Total Sum]
From #tampTable
Group By Class, Section With Cube
GO

--Again RollUp
Select Class, Section, Roll, Sum(Marks) As [Sum]
From #tampTable
Group By Class, Section, Roll With Rollup
GO

--Grouping
Select Class, Section, Roll, Sum(Marks) As [Sum]
From #tampTable
Group By Grouping Sets (
		 (Class, Section, Roll)
		,(Class)
)
GO

-------==================================
--Select Queary and Subqueary, CLE expression name and Column list
-------==================================
Use InventoryProject_DB
With Office_CTE(OfficeID,FormattedOfficeID,OfficeName,OfficeCode)
As
(
	Select OfficeID,FormattedOfficeID,OfficeName,OfficeCode
	From Office
	Where OfficeCode Is Not Null
)
Select * From Office_CTE

-------==================================
----- Sequence for Table
-------==================================
Use InventoryProject_DB
Create Sequence sq_Contacts
	As Bigint
	Start With 1
	Increment By 1
	Minvalue 1
	Maxvalue 99999
	No Cycle
	Cache 10;
	GO

Select Next value for sq_Contacts;
GO

-------==================================
-------Case
-------==================================
Select ProductID, StockID,
	Case StockID
	When 1 then 'MS Dos'
	When 2 then 'Web Design'
	When 3 then 'Base'
	When 4 then 'Trade'
	When 5 then 'C#'
	When 6 then 'Alpha'
	When 7 then 'WDA'
	When 8 then 'Sharp'
	When 9 then 'Concert'
	When 10 then 'Software Engineering'
	When 11 then 'Python'
	When 12 then 'Java'
		Else 'Not Allow'
End	 
From store.Stock
Go

-------==================================
--Cast, Convert, Concatenation
-------==================================
SELECT 'Today : ' + CAST(GETDATE() as varchar)
Go

SELECT 'Today : ' + CONVERT(varchar,GETDATE(),1)
Go


--=====================================
--Operator
--=====================================
Select 10+2 as [Sum]
Go
Select 10-2 as [Substraction]
Go
Select 10*3 as [Multiplication]
Go
Select 10/2 as [Divide]
Go
Select 10%3 as [Remainder]
Go


--Distinct
Select Distinct ProductID,ProductName,ProductCode
From store.Product
Go

--Sub Query
Select * 
From store.Product
Where ProductCode in (Select ProductCode From store.Product Where ProductCode>20)
Go

