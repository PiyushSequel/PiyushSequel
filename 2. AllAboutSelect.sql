/*1.Select specific or all columns.
  2.Distinct rows.
  3.Filtering with where clause.
  4.Wild Cards in SQL Server.
  5.Joining multiple conditions using AND and OR operators.
  6.Sorting rows using order by.
  7.Select Top N or Top N Percentage of rows.*/

/* %--Specifies zero or more characters
   _--Specifies exactly one character
   []--Any character with in the brackets
   [^]--Not any character with in the brackets
*/
Select * from tblPerson2/*But, specifying column name except '*' is good practise and improves performances*/

Select distinct Name, City from tblPerson2

Select ID, Name from tblPerson2 where City = 'London'/*Where Clause is used to limit the rows*/

Select * from tblPerson2 where City <> 'London'/*Returning Except London*/

Select * from tblPerson2 where City != 'London'/*Same as above*/

Select * from tblPerson2 where Age >= 18

--IN Operator(Used to specify a list of values)
Select * from tblPerson2 where Age = 18 or Age = 20 or Age = 22

Select * from tblPerson2 where Age in (18, 20, 22)

--BETWEEN Operator(To specify a range of values)
Select * from tblPerson2 where Age between 18 and 20

--LIKE Operator(To specify a Pattern)
Select * from tblPerson2 where City like 'L%'/*Whatever after L, will return*/

Select * from tblPerson2 where email like '%@%'/*Whatever before and after @, will return*/

Select * from tblPerson2 where email like '_@_'/*Returns one Char before @ and one char after @*/

Select * from tblPerson2 where Name like '[HNJ]%'/*Returns starting from the letters in []*/

Select * from tblPerson2 where Name like '[^HNJ]%'/*Returns which are not starting from the letters in []*/

--NOT Operator(Not in a List, Range Etc.)
Select * from tblPerson2 where email not like '%@%'/*Will return which are invalid Emails means without @*/

--Use of OR, AND
Select * from tblPerson2 where City='London' or City='Pune' and Age>25
Select * from tblPerson2 where (City='London' or City='Pune') and Age>25

--ORDER BY(Sort the result by DESC or ASC)
Select * from tblPerson2 order by name

Select * from tblPerson2 order by Name desc, Age asc

--Top N
Select Top 2 * from tblPerson2

--Top N Percentage
Select Top 50 percent * from tblPerson2

--Use of TOP in Getting Eldest Person
Select Top 1 * from tblPerson2 order by Age desc