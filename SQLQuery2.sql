-- Ẻ�֡�Ѵ����� SQL ��ҹ������ Northwind --
--1. ��ͧ������ʾ�ѡ�ҹ �ӹ�˹�� ���� ���ʡ�� �ͧ��ѡ�ҹ�����������ͧ London--
select EmployeeID,FirstName,LastName
from Employees
where city = 'london'

--2. ��ͧ��â������Թ��ҷ�������ʻ����� 1,2,4,8 ������Ҥ� ��ǧ 50-100$
select ProductID
from Products
where CategoryID in (1,2,4,8) And UnitPrice Between 50 And 100
--3. ��ͧ��û���� ���ͧ ���ͺ���ѷ�١��� ���ͼ��Դ��� ������ �ͧ�١��ҷ�����
select Country,City,CompanyName,ContactName,Phone
from Customers
order by country,city,companyName

--4. �����Ţͧ�Թ������ʻ�������� 1 �Ҥ�����Թ 50 �����Թ������ʻ�������� 8 �Ҥ�����Թ 75
select * from Products
where (CategoryID = 1 And unitPrice >= 50)
  or (categoryID = 8 And UnitPrice <= 75)

--5. ���ͺ���ѷ�١��� �������� ����� USA �������������Ţ FAX  ���§����ӴѺ���ͺ���ѷ 
select CompanyName 
from customers
where  Fax is Null and Country = 'USA'

--��ͧ��������١��� ���ͺ���ѷ ��� ���ͼ��Դ��� ੾�� ���ͺ���ѷ����դ���� 'con'
select CustomerID,CompanyName,ContactName
from Customers
where CompanyName like '%con%'

select ProductID,ProductName,
			UnitPrice,UnitsinStock,
			UnitPrice*UnitsinStock As StockValue --Alias Name--
from Products

select * from products

select ProductID as ����, ProductName as �Թ���,
	UnitsinStock + UnitsOnOrder as �ӹǹ������ͷ�����,
	ReorderLevel as �ش��觫���
from Products
where (UnitsinStock + UnitsOnOrder) < ReorderLevel

select ProductID,ProductName,
			UnitPrice,ROUND(UnitPrice * 0.07, 2) as Vat7
from Products

select employeeID,
TitleOfCourtesy+Firstname+space(1)+lastname as [Employee Name]
from Employees

--��ͧ��äӹǳ��¡�â���Թ������¡�â�·�� 10250 ����ҧ [Order deta]
select OrderID,ProductID,UnitPrice,Quantity,Discount,
		(unitPrice*Quantity) - (UnitPrice* Quantity* Discount)
from [Order Details]
where orderID = 10250

select OrderID,ProductID,unitPrice,Quantity,Discount,
			UnitPrice * Quantity * (1-Discount)
from [Order details]
where orderID = 10250

--����� Aggregate function
select COUNT(*) �ӹǹ�Թ���
from Products
where UnitsinStock < 15

select COUNT(*) ��ѡ�ҹ������
from employees

select COUNT(*) from Customers where Country = 'Brazill'

select COUNT(*) from [Order Details] where orderID = 10250

select COUNT(*) from orders where shipcountry = 'japan'

--��ͧ����Ҥ��Թ��ҵ���ش �٧�ش ��������
select min(UnitPrice) as �Ҥҵ���ش, Max(UnitPrice) as �Ҥ��٧�ش,
		AVG(UnitPrice) as ��������
from products

--��ͧ����Ҥ������ �Ҥ��٧�ش ����Ҥҵ���ش�ͧ�Թ������� 5 ������� [order details]
select AVG(UnitPrice)as ��������, Max(UnitPrice)as ����٧�ش, Min(UnitPrice)as ��ҵ���ش
from [Order Details]
where ProductID = 5

--���ͻ���� ��Шӹǹ�١�������л����
select Country,Count(*)as [�ӹǹ�١���]
from Customers
Group By country
order by [�ӹǹ�١���] desc

--���ͻ���� ���ͧ ��Шӹǹ�١�����������ͧ
select country, city, count(*) as �ӹǹ�١���
from customers
group by Country
order by [�ӹǹ�١���] desc

--��ͧ��â����Ũӹǹ���觫��ͷ���������л���� --orders
select shipcountry, count(*)as �ӹǹ���觫���
from orders
group by shipcountry

--���ͻ���� ���ͧ ��Шӹǹ�١�����������ͧ--- ������١��ҹ��¡��� 5 ���
select Country, count(*)as �ӹǹ�١���
from customers
group by country
HAVING count(*) < 5
order by [�ӹǹ�١���] desc

--���ͻ���� ���ͧ ��Шӹǹ�١�����������ͧ--- �����١����ҡ���� 1 ���
select Country, count(*)as �ӹǹ�١���
from customers
group by country
HAVING count(*) > 1


--���ͻ���� ���ͧ ��Шӹǹ�١�����������ͧ--- �����١����ҡ���� 100 ���
select shipcountry, count(*)as �ӹǹ�١���
from orders
group by shipcountry
HAVING count(*)> 100

--��ͧ��èӹǹ���觫��ͷ���������л����੾��㹻� 1997
--㹻���ȷ���ըӹǹ���¡��� 5 ��¡��
select shipcountry, count(*) �ӹǹ���觫���
from orders
where YEAR(orderDate) = 1997
group by shipcountry
Having count(*) <5

--��ͧ��������Թ��� ���Ҩӹǹ��������ҡ����ش-- �Ҥ��٧�ش �Ҥҵ���ش �Ҥ������
select productID,sum(Quantity) as �ӹǹ�������,
		Max(unitPrice) �Ҥ��٧�ش, MIN(UnitPrice) �Ҥҵ���ش, 
		AVG(UnitPrice)�Ҥ�������
from [Order Details]
group by productID
having sum(Quantity)>1000
order by productID

--��ͧ����������觫��� ����ʹ��������������觫���[order details]
select orderID, sum(UnitPrice * QUantity * (1-Discount))as TotalPrice
from [Order Details]
group by orderID
