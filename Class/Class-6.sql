-- Joins : In order to combine and fetch 2 or more tables data 

-- Inner : the combination of matched values from both the tables it will fetch 
-- left:  inner join + remaining values from left side table , if the value notmatch print as null 
--                     or 
-- 	  print all the values from left side table , matching values fom right side if not match print as null				
-- right: inner join + remaining values from right side table , if the value not match print as null 
--                        or 
-- 	 print all the values from right side table , matching values fom left side if not match print as null	
-- full: combination of right and left joins 

-- self: the table it self if you want to perform any joins we are goin to use self join 
--        mainly hireacial data (emp id --manger id ) 
-- cross : its multiply with both tables (3*5) or permutations and combinations 



-- https://github.com/  --> create account 

-- https://git-scm.com/install/windows  --> install software 

-- https://code.visualstudio.com/download?_exp_download=fb315fc982 --> vs code 




CREATE TABLE  TAB_A  (ID INT) ;

CREATE TABLE  TAB_B  (ID INT) ;


INSERT INTO TAB_A (ID) VALUES (1),(3),(4),(5),(6) ;


INSERT INTO TAB_B (id) VALUES
(1),
(2),
(3),
(6),
(7),
(8);


SELECT * FROM TAB_A   ;

SELECT * FROM TAB_B   ;



SELECT A.* , B.* 
   FROM TAB_A   A  INNER JOIN TAB_B  B  
    ON  A.ID = B.ID ;

SELECT A.* , B.* 
   FROM TAB_A   A  LEFT JOIN TAB_B  B  
    ON  A.ID = B.ID ;


SELECT A.* , B.* 
   FROM TAB_A   A  RIGHT JOIN TAB_B  B  
    ON  A.ID = B.ID ;


SELECT A.* , B.* 
   FROM TAB_A   A  FULL JOIN TAB_B  B  
    ON  A.ID = B.ID ;

SELECT A.* , B.* 
   FROM TAB_A   A  CROSS JOIN TAB_B  B  ;



   SELECT * FROM EMPLOYEES;


   SELECT * FROM DEPARTMENTS ; 

   UPDATE DEPARTMENTS 
      SET DEPARTMENT_ID = 100 
      WHERE DEPARTMENT_ID =10




   SELECT X.EMPLOYEE_ID,
          X.FIRST_NAME,
          X.SALARY,
          X.DEPARTMENT_ID,
          Y.DEPARTMENT_NAME 
   
   FROM EMPLOYEES X INNER JOIN DEPARTMENTS Y
        ON X.DEPARTMENT_ID = Y.DEPARTMENT_ID


    
   SELECT X.EMPLOYEE_ID,
          X.FIRST_NAME,
          X.SALARY,
          X.DEPARTMENT_ID,
          Y.DEPARTMENT_NAME 
   FROM EMPLOYEES X LEFT JOIN DEPARTMENTS Y
        ON X.DEPARTMENT_ID = Y.DEPARTMENT_ID





   SELECT X.EMPLOYEE_ID,
          X.FIRST_NAME,
          X.SALARY,
          X.DEPARTMENT_ID,
          Y.DEPARTMENT_NAME 
   FROM EMPLOYEES X RIGHT JOIN DEPARTMENTS Y
        ON X.DEPARTMENT_ID = Y.DEPARTMENT_ID


        
   SELECT X.EMPLOYEE_ID,
          X.FIRST_NAME,
          X.SALARY,
          X.DEPARTMENT_ID,
          Y.DEPARTMENT_NAME 
   FROM EMPLOYEES X FULL JOIN DEPARTMENTS Y
        ON X.DEPARTMENT_ID = Y.DEPARTMENT_ID


        -----------------

         SELECT X.EMPLOYEE_ID,
          X.FIRST_NAME,
          X.SALARY,
          X.DEPARTMENT_ID,
          Y.DEPARTMENT_NAME,
          C.CITY 
   FROM EMPLOYEES X INNER JOIN DEPARTMENTS Y
        ON X.DEPARTMENT_ID = Y.DEPARTMENT_ID
        INNER JOIN LOCATIONS C 
        ON Y.LOCATION_ID = C.LOCATION_ID


SELECT * FROM EMPLOYEES;


-- Self join to get employee with manager name
SELECT 
    e.employee_id AS emp_id,
    e.first_name   AS emp_name,
    m.employee_id AS mgr_id,
    m.first_name   AS mgr_name
FROM employees e
 JOIN employees m
    ON e.manager_id = m.employee_id
ORDER BY e.employee_id;



-- Create TEAMS table
CREATE OR REPLACE TABLE TEAMS (
    team_name STRING
);

-- Insert values
INSERT INTO TEAMS (team_name) VALUES
('SRH'),
('CHN'),
('RCB'),
('GT');


-- Cross join TEAMS with itself
SELECT 
    t1.team_name AS team1,
    t2.team_name AS team2
FROM TEAMS t1
CROSS JOIN TEAMS t2
WHERE  t1.team_name <  t2.team_name
--ORDER BY team1, team2;


-- Windows functions :

--   ROW_NUMBER  :
--   RANK 
--   DENSE_RANK
--   LEAD 
--   LAG 
  
  
  
--   tASK :
  
  
--   MID    MONTH_NAME AMOUNT 
--   ------------------------
--   1     JAN         20000
--   2      FEB         30000
--   3      MAR        10000 
--   ..
--   ...
--   ...
--   12    DEC         45000
  
  
--   I WNAT TO SEE PROFIT OR LOSS  (lEAD /LAG) 
  
--     MID    MONTH_NAME AMOUNT      PROFIT_LOSS
--   -----------------------------------------
--   1     JAN         20000          nA
--   2      FEB        30000        10000
--   3      MAR        10000        -20000
--   ..
--   ...
--   ...
--   12    DEC         45000
  
  
--  sql :
--  --------------






CREATE OR REPLACE TABLE MONTHLY_SALES (
    MID INT,
    MONTH_NAME VARCHAR(10),
    AMOUNT NUMBER(10,2)
);



INSERT INTO MONTHLY_SALES VALUES
(1, 'JAN', 20000),
(2, 'FEB', 30000),
(3, 'MAR', 10000),
(4, 'APR', 25000),
(5, 'MAY', 35000),
(6, 'JUN', 40000),
(7, 'JUL', 30000),
(8, 'AUG', 50000),
(9, 'SEP', 45000),
(10, 'OCT', 60000),
(11, 'NOV', 35000),
(12, 'DEC', 45000);






SELECT
    MID,
    MONTH_NAME,
    AMOUNT,
    AMOUNT - LAG(AMOUNT) OVER (ORDER BY MID) AS PROFIT_LOSS
FROM MONTHLY_SALES
ORDER BY MID;






SELECT CURRENT_DATABASE(), CURRENT_SCHEMA();

SHOW TABLES LIKE 'MONTHLY_SALES';






SELECT
    MID,
    MONTH_NAME,
    AMOUNT,
    AMOUNT - LAG(AMOUNT) OVER (ORDER BY MID) AS PROFIT_LOSS,
    CASE
        WHEN LAG(AMOUNT) OVER (ORDER BY MID) IS NULL
            THEN 'NA'
        WHEN AMOUNT > LAG(AMOUNT) OVER (ORDER BY MID)
            THEN 'PROFIT'
        WHEN AMOUNT < LAG(AMOUNT) OVER (ORDER BY MID)
            THEN 'LOSS'
        ELSE 'NO CHANGE'
    END AS STATUS
FROM MONTHLY_SALES
ORDER BY MID;
