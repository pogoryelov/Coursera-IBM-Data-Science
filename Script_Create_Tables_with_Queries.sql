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