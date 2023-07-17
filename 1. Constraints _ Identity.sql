create database kudvenkat
use kudvenkat

create table tblGender(ID int not null Primary Key,
					   Gender varchar(50) not null);

create table tblPerson(ID int not null Primary Key,
					   Name varchar(50),
					   Email varchar(50),
					   GenderID int Foreign Key references tblGender(ID));

insert into tblGender values(1, 'Male'), 
							(2, 'Female'),
							(3, 'Unknown');

insert into tblPerson values(1, 'Jade', 'm@m.com', 2),
							(2, 'Mary', 'm@n.com', 3),
							(3, 'Martin', 'm@o.com', 1),
							(4, 'Rob', 'r@r.com', Null),
							(5, 'May', 'may@may.com', 2),
							(6, 'Kristy', 'k@k.com', Null);

select * from tblGender;
select * from tblPerson;

/*
Primary Key---1). Combination of NOT NULL and UNIQUE Constraints. Uniquely identifies each row.
			  2). No NULL Values, One PK per table.
			  3). Note: Can't create PK on Nullable Column. 

Foreign Key---1). A FOREIGN KEY is a key used to link two tables together.
			  2). A FOREIGN KEY is a field (or collection of fields) in one table that refers(POINTS) to the PRIMARY KEY in another table.
			  3). A FOREIGN KEY is used to enforce database integrity(Referential Integrity).
			  4). A FOREIGN KEY column can have NULL values as well as Duplicate Values.
			  5). Note: The table with the foregin key is called Child Table, and this foregin key referenced 
			      with another table's primary key Called Parent table.
*/
--Altering Table to Add Primary Key Constraints in tblPerson table
Alter table tblPerson add constraint tblPerson_ID_PK Primary Key(ID)
--Altering Table to Drop Primary Key Constraints in tblPerson table
Alter table tblPerson drop constraint tblPerson_ID_PK
--Altering Table to Add a Foreign Key Constraints in tblPerson table
Alter table tblPerson add constraint tblPerson_GenderID_FK foreign key(GenderID) references tblGender(ID)
--Altering Table to Drop a Foreign Key Constraints in tblPerson table
Alter table tblPerson drop constraint tblPerson_GenderID_FK


--Check Constraint:
--It Checks the values on a condition while entering them and then if it false out then it throws an error.
--If we pass null then if that column is Nullable then Null values will be inserted treating it as UNKNOWN.

--Add Age Column along with Check Constraint
Alter table tblPerson add Age int check (Age>0 and Age<150);

--Altering a table to add Check Constraint
Alter table tblPerson add constraint CK_Age check (Age>0 and Age<150)

Insert into tblPerson values(7, 'Rozi', 'r@r.com', 1, 25);
Insert into tblPerson values(8, 'Razi', 'q@q.com', 2, null);--UNKNOWN AGE due to NULL

Select * from tblPerson;

--To drop above Check Constraint
Alter table tblPerson drop constraint CK_Age 

--Altering a table to add Unique Constraint
Alter table tblPerson add constraint UQ_Name unique(Name)
Insert into tblPerson values(9, 'Scott', 's@c.com', 1, 30)

Select * from tblPerson;

--To drop above Unique Constraint
Alter table tblPerson drop constraint UQ_Name


--Default Constraint: The DEFAULT constraint is used to provide a default value for a column.The default value will be added to
--all new records, if no other value is specified.
--Altering an existing column to add a default constraint
Alter table tblPerson add constraint DF_GenderID default 3 for GenderID

Insert into tblPerson(ID, Name, Email, Age) values(10, 'Mutt', 'm@d.com', 30);
Select * from tblPerson;
--Note: We can also insert null values in it.
Insert into tblPerson values(11, 'Zoks', 'z@z.com', null, 32);

--Adding a new column with default constraints to an existing table
Alter table tblGender add City varchar(20) constraint DF_City default 'Noida'
--Dropping of above Constraint
Alter table tblGender drop DF_City
Alter table tblGender Drop Column City



/* Note: Cascading Referential Integrity: We can go ahead In foreign key using UI of SSMS and make changes in 
'Insert and Update Specification', can set 'Delete Rrule' to either of the Following:
1. No Action
2. Cascade : Deleting Parent Table Record(S), will delete Child Table Record(S).
3. Set Null
4. Set Default */



--Identity: If a column is IDENTITY, then the value for this column are automatically generated, when you insert a new row.
--Note: ALTER is not possible for IDENTITY.
Create table tblPerson1(ID int identity(1,1), Name varchar(30))
Insert into tblPerson1 values('Jai')
Insert into tblPerson1 values('Vijoy')
Insert into tblPerson1 values('Rajesh')

Select * from tblPerson1;

Insert into tblPerson1(ID, Name) values(4, 'Jai');
--Error for Above: "Cannot insert explicit value for identity column in table 'tblPerson1' when IDENTITY_INSERT is set to OFF."
--To insert data explicitly
Set identity_insert tblPerson1 ON
--Then Insert by specifying Column Names
Insert into tblPerson1(ID, Name) values(4, 'Jai');
select * from tblPerson1
--For again Using IDENTITY run following comand
Set identity_insert tblPerson1 OFF
Insert into tblPerson1 values('Veeru');

Select * from tblPerson1;

--To insert data after deleting records from start as it starts after where it was. So in case of RESETTING IDENTITY follow as bellow:
DBCC CHECKIDENT(tblPerson1, RESEED, 0)

--To Get the Last Generated Identity Column Value in SQL Server
Select Scope_Identity() /*Works in same Session(Connection) and the same Scope*/
Select @@Identity /*Works in same Session(Connection) and across any Scope*/
Select Ident_Current('TableName') /*Specific table across any session(Connection) and any scope*/