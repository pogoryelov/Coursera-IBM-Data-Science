------------------------------------------
--DDL statement for table 'HR' database--
--------------------------------------------

CREATE TABLE EMPLOYEES (
                            EMP_ID CHAR(9) NOT NULL, 
                            F_NAME VARCHAR(15) NOT NULL,
                            L_NAME VARCHAR(15) NOT NULL,
                            SSN CHAR(9),
                            B_DATE DATE,
                            SEX CHAR,
                            ADDRESS VARCHAR(30),
                            JOB_ID CHAR(9),
                            SALARY DECIMAL(10,2),
                            MANAGER_ID CHAR(9),
                            DEP_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (EMP_ID));
                            
  CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL, 
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID));
 
 CREATE TABLE JOBS (
                            JOB_IDENT CHAR(9) NOT NULL, 
                            JOB_TITLE VARCHAR(25) ,
                            MIN_SALARY DECIMAL(10,2),
                            MAX_SALARY DECIMAL(10,2),
                            PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL, 
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (LOC_ID));

CREATE TABLE LOCATIONS (
                            LOCT_ID CHAR(9) NOT NULL,
                            DEP_ID_LOC CHAR(9) NOT NULL,
                            PRIMARY KEY (LOCT_ID,DEP_ID_LOC));


--------------------------------------------------------
--------------------------------------------------------
--LAB: String Patterns, Sorting & Grouping
--------------------------------------------------------
--------------------------------------------------------

---------------------------------------------------
--Query 1: Retrieve all employees whose address is in Elgin,IL
---------------------------------------------------
select address
from employees
where address like '%Elgin,IL';

---------------------------------------------------
--Query 2: Retrieve all employees who were born during the 1970's.
---------------------------------------------------
select b_date
from employees
where b_date like '197%';

---------------------------------------------------
--Query 3: Retrieve all employees in department 5 whose salary is between 60000 and 70000
---------------------------------------------------
select *
from employees
where dep_ID=5 and salary between 60000 and 70000;

---------------------------------------------------
--Query 4A: Retrieve a list of employees ordered by department ID.
---------------------------------------------------
select *
from employees
order by dep_ID;

---------------------------------------------------
--Query 4B: Retrieve a list of employees ordered in descending order by department ID and within each department ordered alphabetically in descending order by last name.
---------------------------------------------------
select *
from employees
order by dep_ID desc, L_NAME desc;

---------------------------------------------------
--Query 5A: For each department ID retrieve the number of employees in the department.
---------------------------------------------------
select dep_ID, count(*)
from employees
group by dep_ID;

---------------------------------------------------
--Query 5B: For each department retrieve the number of employees in the department, and the average employees salary in the department.
---------------------------------------------------
select dep_ID, count(*), avg(salary)
from employees
group by dep_ID;

---------------------------------------------------
--Query 5C: Label the computed columns in the result set of Query 5B as “NUM_EMPLOYEES” and “AVG_SALARY”.
---------------------------------------------------
select dep_ID, count(*) as Num_Employees, avg(salary) as Avg_Salary
from employees
group by dep_ID;

---------------------------------------------------
--Query 5D: In Query 5C order the result set by Average Salary.
---------------------------------------------------
select dep_ID, count(*) as Num_Employees, avg(salary) as Avg_Salary
from employees
group by dep_ID
order by Avg_Salary;

---------------------------------------------------
--Query 5E: In Query 5D limit the result to departments with fewer than 4 employees.
---------------------------------------------------
select dep_ID, count(*) as Num_Employees, avg(salary) as Avg_Salary
from employees
group by dep_ID
having count(*)<4
order by Avg_Salary;

---------------------------------------------------
--BONUS Query 6: Similar to 4B but instead of department ID use department name.
--Retrieve a list of employees ordered by department name, and within each department ordered alphabetically in descending order by last name.
---------------------------------------------------
select D.dep_name, E.F_name, E.L_name
from employees as E, departments as D
where E.dep_ID = D.dept_ID_dep
order by D.dep_name, E.L_name desc;

SELECT F_NAME, DEP_NAME FROM EMPLOYEES, DEPARTMENTS WHERE DEPT_ID_DEP = DEP_ID;


--------------------------------------------------------
--------------------------------------------------------
--LAB: JOIN Operations
--------------------------------------------------------
--------------------------------------------------------

---------------------------------------------------
--Query 1A: Select the names and job start dates of all employees who work for the department number 5.
---------------------------------------------------
select E.F_name, E.L_name, JH.start_date
from Employees E inner join Job_history JH
on E.emp_ID = JH.empl_ID
where E.dep_ID=5;

---------------------------------------------------
--Query 1B: Select the names, job start dates, and job titles of all employees who work for the department number 5
---------------------------------------------------
select E.F_name, E.L_name, JH.start_date, j.Job_title
from Employees E
	inner join Job_history JH on E.emp_ID = JH.empl_ID
	inner join Jobs J on j.Job_ident = E.Job_ID
where E.dep_ID=5;

---------------------------------------------------
--Query 2A: Perform a Left Outer Join on the EMPLOYEES and DEPARTMENT tables and select employee id, last name, department id and department name for all employees
---------------------------------------------------
select E.Emp_ID, E.L_name, E.Dep_ID, D.Dep_name
from Employees E
left outer join Departments D
on E.Dep_ID = D.Dept_ID_dep;

---------------------------------------------------
--Query 2B: Re-write the query for 2A to limit the result set to include only the rows for employees born before 1980
---------------------------------------------------
select E.Emp_ID, E.L_name, E.Dep_ID, D.Dep_name
from Employees E
left outer join Departments D
on E.Dep_ID = D.Dept_ID_dep
where year(E.b_date) < 1980;

---------------------------------------------------
--Query 2C: Re-write the query for 2A to have the result set include all the employees but department names for only the employees who were born before 1980.
---------------------------------------------------
select E.Emp_ID, E.L_name, E.Dep_ID, D.Dep_name
from Employees E
left outer join Departments D
on E.Dep_ID = D.Dept_ID_dep
and year(E.b_date) < 1980;

---------------------------------------------------
--Query 3A: Perform a Full Join on the EMPLOYEES and DEPARTMENT tables and select the First name, Last name and Department name of all employees.
---------------------------------------------------
select E.F_name, E.L_name, D.Dep_name
from Employees E
full outer join Departments D
on E.Dep_ID = D.Dept_ID_dep;

---------------------------------------------------
--Query 3B: Re-write Query 3A to have the result set include all employee names but department id and department names only for male employees.
---------------------------------------------------
select E.F_name, E.L_name, D.Dept_ID_dep, D.Dep_name
from Employees E
full outer join Departments D
on E.Dep_ID = D.Dept_ID_dep
and E.Sex = 'M';