-- แบบฝึกหัดคำสั่ง SQL ใช้ฐานข้อมูล Northwind --
--1. ต้องการรหัสพนักงาน คำนำหน้า ชื่อ นามสกุล ของพนักงานที่อยู่ในเมือง London--
select EmployeeID,FirstName,LastName
from Employees
where city = 'london'

--2. ต้องการข้อมูลสินค้าที่มีรหัสประเภท 1,2,4,8 และมีราคา ช่วง 50-100$
select ProductID
from Products
where CategoryID in (1,2,4,8) And UnitPrice Between 50 And 100
--3. ต้องการประเทศ เมือง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทร ของลูกค้าทั้งหมด
select Country,City,CompanyName,ContactName,Phone
from Customers
order by country,city,companyName

--4. ข้อมูลของสินค้ารหัสประเภทที่ 1 ราคาไม่เกิน 50 หรือสินค้ารหัสประเภทที่ 8 ราคาไม่เกิน 75
select * from Products
where (CategoryID = 1 And unitPrice >= 50)
  or (categoryID = 8 And UnitPrice <= 75)

--5. ชื่อบริษัทลูกค้า ที่อยู่ใน ประเทศ USA ที่ไม่มีหมายเลข FAX  เรียงตามลำดับชื่อบริษัท 
select CompanyName 
from customers
where  Fax is Null and Country = 'USA'

--ต้องการรหัสลูกค้า ชื่อบริษัท และ ชื่อผู้ติดต่อ เฉพาะ ชื่อบริษัทที่มีคำว่า 'con'
select CustomerID,CompanyName,ContactName
from Customers
where CompanyName like '%con%'

select ProductID,ProductName,
			UnitPrice,UnitsinStock,
			UnitPrice*UnitsinStock As StockValue --Alias Name--
from Products

select * from products

select ProductID as รหัส, ProductName as สินค้า,
	UnitsinStock + UnitsOnOrder as จำนวนคงเหลือทั้งหมด,
	ReorderLevel as จุดสั่งซื้อ
from Products
where (UnitsinStock + UnitsOnOrder) < ReorderLevel

select ProductID,ProductName,
			UnitPrice,ROUND(UnitPrice * 0.07, 2) as Vat7
from Products

select employeeID,
TitleOfCourtesy+Firstname+space(1)+lastname as [Employee Name]
from Employees

--ต้องการคำนวณรายการขายสินค้าในรายการขายที่ 10250 ใช้ตาราง [Order deta]
select OrderID,ProductID,UnitPrice,Quantity,Discount,
		(unitPrice*Quantity) - (UnitPrice* Quantity* Discount)
from [Order Details]
where orderID = 10250

select OrderID,ProductID,unitPrice,Quantity,Discount,
			UnitPrice * Quantity * (1-Discount)
from [Order details]
where orderID = 10250

--การใช้ Aggregate function
select COUNT(*) จำนวนสินค้า
from Products
where UnitsinStock < 15

select COUNT(*) พนักงานทั้งหมด
from employees

select COUNT(*) from Customers where Country = 'Brazill'

select COUNT(*) from [Order Details] where orderID = 10250

select COUNT(*) from orders where shipcountry = 'japan'

--ต้องการราคาสินค้าต่ำสุด สูงสุด ค่าเฉลี่ย
select min(UnitPrice) as ราคาต่ำสุด, Max(UnitPrice) as ราคาสูงสุด,
		AVG(UnitPrice) as ค่าเฉลี่ย
from products

--ต้องการราคาเฉลี่ย ราคาสูงสุด และราคาต่ำสุดของสินค้ารหัส 5 ที่ขายได้ [order details]
select AVG(UnitPrice)as ค่าเฉลี่ย, Max(UnitPrice)as ค่าสูงสุด, Min(UnitPrice)as ค่าต่ำสุด
from [Order Details]
where ProductID = 5

--ชื่อประเทศ และจำนวนลูกค้าในแต่ละประเทศ
select Country,Count(*)as [จำนวนลูกค้า]
from Customers
Group By country
order by [จำนวนลูกค้า] desc

--ชื่อประเทศ เมือง และจำนวนลูกค้าในแต่ละเมือง
select country, city, count(*) as จำนวนลูกค้า
from customers
group by Country
order by [จำนวนลูกค้า] desc

--ต้องการข้อมูลจำนวนใบสั่งซื้อที่ส่งไปในแต่ละประเทศ --orders
select shipcountry, count(*)as จำนวนใบสั่งซื้อ
from orders
group by shipcountry

--ชื่อประเทศ เมือง และจำนวนลูกค้าในแต่ละเมือง--- ที่มีลูกค้าน้อยกว่า 5 ราย
select Country, count(*)as จำนวนลูกค้า
from customers
group by country
HAVING count(*) < 5
order by [จำนวนลูกค้า] desc

--ชื่อประเทศ เมือง และจำนวนลูกค้าในแต่ละเมือง--- ที่ทีลูกค้ามากกว่า 1 ราย
select Country, count(*)as จำนวนลูกค้า
from customers
group by country
HAVING count(*) > 1


--ชื่อประเทศ เมือง และจำนวนลูกค้าในแต่ละเมือง--- ที่ทีลูกค้ามากกว่า 100 ราย
select shipcountry, count(*)as จำนวนลูกค้า
from orders
group by shipcountry
HAVING count(*)> 100

--ต้องการจำนวนใบสั่งซื้อที่ส่งไปในแต่ละประเทศเฉพาะในปี 1997
--ในประเทศที่มีจำนวนน้อยกว่า 5 รายการ
select shipcountry, count(*) จำนวนใบสั่งซื้อ
from orders
where YEAR(orderDate) = 1997
group by shipcountry
Having count(*) <5

--ต้องการรหัสสินค้า และาจำนวนที่ขายได้มากที่สุด-- ราคาสูงสุด ราคาต่ำสุด ราคาเฉลี่ย
select productID,sum(Quantity) as จำนวนที่ขายได้,
		Max(unitPrice) ราคาสูงสุด, MIN(UnitPrice) ราคาต่ำสุด, 
		AVG(UnitPrice)ราคารเฉลี่ย
from [Order Details]
group by productID
having sum(Quantity)>1000
order by productID

--ต้องการรหัสใบสั่งซื้อ และยอดขายรวมในแต่ละใบวั่งซื้อ[order details]
select orderID, sum(UnitPrice * QUantity * (1-Discount))as TotalPrice
from [Order Details]
group by orderID
