/****** Script for SelectTopNRows command from SSMS  ******/
Select * From Foodstuffs

---changing the datatype of the DATE column from a Datetime datatype to a Date datatype

ALTER TABLE Foodstuffs
 ALTER COLUMN Date Date

---changing the DATE column to DatePurchased
EXEC sp_rename 
'Foodstuffs.Date', 'DatePurchased' , 'Column'

---excluding MILK from the Product Column
select * from Foodstuffs
where Product <> 'Milk'

---ordering the table by the DatePurchased
select * from Foodstuffs
where product <> 'Milk'
order by DatePurchased

