/* ================== COUNT and other AGGREGATE functions ================*/
/* lets explore functions some more
one of the most useful fucntions is count(*) which counts the number of rows retrieved */
select count(*) from r;
select count(*) from ratings;

select count(*) from m;
select count(*) from movies;

select count(*) from u;
select count(*) from users;
/* how many ratings are there in r? In ratings? */
select count(rating) from r;
select count(rating) from ratings;

/* how many action movies? */
SELECT title, ACTION FROM m; 
select count(title) from m where action=1;
/* note: two action movies and one null */
select count(title) from m where action=0;
select count(title) from m where action=0 or action is null;
select count(title) from m where if(action is null,0,action)=0;
select count(title) from m where ifnull(action,0)=0;
  /* NOTE: null not included */

/* How many reviewers have written reviews? */
select count(distinct userid) from r;
/* find the average rating */
select avg(rating) from r;

/* other useful fucntions: min(), max(), etc. */
select avg(rating),min(rating), max(rating) from r;
/* see more at
https://dev.mysql.com/doc/refman/5.7/en/group-by-functions.html */

/* find the average rating of movieid 1 */
select avg(rating),min(rating), max(rating) from r where movieid = 1;
/* how about average for each movie?  */

/*================  GROUP BY =====================*/
/* the optional clause "GROUP BY expression" divides the rows retrieved into as many groups
are there are values for the expression.
For each group you can report (1) group stats (2) group definition */
select * from r;
select movieid,avg(rating),min(rating),max(rating) from r
group by movieid;
 

/* find the avg rating by month of review for movieid 1 */
select month(ts), avg(rating) from r where movieid =1
group by month(ts);

/* the where clause operates first,
group by second
and reports last */
/* try this */


/* ============= HAVING ==================================== */
/* what if you are only interested in months with more than 60 reviews?  
use the optional HAVING clause
the HAVING clause is like the WHERE clause except that it operates at the group level
only groups that satisfy the HAVING clause qualify */
select * from r;
select movieid,avg(rating),min(rating),max(rating) from r
group by movieid;

/* some times a where clause may work, prefer that as it reduces grouping overhead */
/* find number and average of rating for each month in 1997 */
select movieid, avg(rating),min(rating),max(rating) from r where movieid=1;

/* or less efficiently as */
SELECT MONTH(ts), YEAR(ts),count(*),  AVG(rating)
FROM r
GROUP BY MONTH(ts), YEAR(ts)
Having count(*) >= 60; 

/* ===================  ORDER BY ========================*/
/* now for the optional ORDER BY clause that lets you 
sort the results (the relation / table is unaffected */

/* report on months in ascending order of month */ 
select month(ts),avg(rating) from r where year(ts)= 1998 
group by month(ts)
order by month(ts);

/* report on months in desccending order of average */ 
select month(ts),year(ts), avg(rating) from r
group by year(ts),month(ts)
order by avg(rating) desc; 


/* movies with average rating above 3.5 */
select month(ts),year(ts), avg(rating) from r
group by year(ts),month(ts)
having avg(rating)>3.5;

/* NULL and order by */
select month(ts),year(ts), avg(rating) from r
group by year(ts),month(ts)
having avg(rating)>3.5
order by avg(rating) desc;
 /* note NULL at top */

 /* note NULL at bottom */

/* what if you want desc but null at top? */