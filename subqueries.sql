Create database economy;
Use economy;

CREATE TABLE Population (
  Ranking INT,
  Economy VARCHAR(50),
  Population INT
);

INSERT INTO Population (Ranking, Economy, Population)
VALUES (1, 'china', 140),
       (2, 'india', 138),
       (3, 'usa', 32);

CREATE TABLE GDP (
  Ranking INT,
  Economy VARCHAR(50),
  GDP INT
);

INSERT INTO GDP (Ranking, Economy, GDP)
VALUES (1, 'usa', 2094000),
       (2, 'china', 1472000),
       (3, 'japan', 506000);
 select * from population;
 select * from gdp;
  -- ------ Subquerirs with expression operators --------- --
Select * from population where economy = 
(select economy from GDP where ranking = 1 );
-- Retrieves the population data for the economy that has a ranking of 1 in the GDP table
Select * from population where economy = ALL
(select economy from GDP where ranking <=10 );
-- Retrieves the population data for the economies that have a ranking of 1 to 10 in the GDP table
select * from population where population  <= ANY
(select GDP from GDP where ranking <= 10);
 /* Retrieves the rows from the population table 
where the population is less than or equal to any of the GDP values 
associated with rankings that are less than or equal to 10 in the GDP table */
select * from population where economy IN 
(select economy from GDP where ranking <=10);
/* retrieve the rows from the population table where the economy matches
any of the economies associated with rankings that are less than or equal to 10 in the GDP table */
-- ------subqueries using clauses--------
CREATE TABLE Course (
  id INT,
  username VARCHAR(50),
  courseName VARCHAR(50),
  courseFee DECIMAL(10, 2),
  courseDuration INT
);
INSERT INTO Course (id, username, courseName, courseFee, courseDuration)
VALUES
  (1, 'Sushma', 'cloud', 30000, 60),
  (2, 'Ashok', 'spark', 20000, 35),
  (3, 'Ashok', 'Dev ops', 30000, 60),
  (4, 'Kiran', 'testing', 5000, 30),
  (5, 'Kiran', 'python', 10000, 40),
  (6, 'Kiran', 'C', 5000, 30),
  (7, 'Devdutt', 'Dev ops', 30000, 60),
  (8, 'Vijay', 'ML', 50000, 90),
  (9, 'Ramana', 'testing', 5000, 30);
select avg(no_of_courses)from(
select count(coursename) as no_of_courses from course
group by username
)as Table1;
/* select count(coursename) as no_of_courses from course -- this will count courses=9
but since its group by username- it will count courses of each username.. 1, 2.3,1,1,1 */
select username from course
group by username having count(coursename) >=
(select avg(no_of_courses) from
(select count(coursename) as no_of_courses from course 
group by username)
as table1);
/*2 sub queries are of 1st question,the 3rd, main query groups the data by username and selects those usernames 
that have a count of courses greater than or equal to the average number of courses taken by users.*/
select username, coursename from course where username in
(select username from course 
group by username having count(coursename)>=
(select avg(no_of_courses) from
(select count(coursename) as no_of_courses from course
group by username) as table1));
/*selects the username and coursename columns from the course table. It filters the rows by including only those 
where the username is in the list of usernames having a count of courses greater than or equal to the average.*/