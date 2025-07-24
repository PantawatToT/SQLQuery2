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




