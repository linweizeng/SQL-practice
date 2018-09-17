/* movielens database , using the smaller tables
   Tables:
   m  movies (10 rows)
   u  users (112 rows)
   r  ratings (651 rows)
   unames user identification (112 rows)
*/

/* === 1 Data Dictionary basics ==== */
SHOW DATABASES;  /* which databases are available */
USE movielens;  /* this is how you select a database */
show TABLES;  /* show the tables in the database */ 
describe m;  /* columns in table */

/* === 2 Projection:  selecting vertical slices  === */

/* see all the rows and columns of table m */
select * from m;
/* NULL represents missing data */

/* see just the titles */
select title from m;
/* output order of columns depends on order in select */
select title,movieid from m;
select movieid, title from m; 

/* === 3 expressions === */
/* Find the running time in minutes of each movie by title */
select title,minutes from m;

/* how about giving it a nicer title? */
select title,minutes/60 as hours from m;

/* how about formatting it further?  */
select title,round(minutes/60,2) as hours from m;

/* find other functions at https://dev.mysql.com/doc/refman/5.7/en/numeric-functions.html 
or do a google search on mysql numeric functions */


/* === 4 Nulls === */
 /* action or adventure */
select title, action or adventure from m;
select title, action or adventure from m where action or adventure = 1;
/* notice that the value for Toy Story 2 is NULL */

/* NULL plus 1 is NULL */
 select title, action or adventure +1 from m;
/* can treat binary variable as logical */
  
/* title and neither action nor adventure */
select title, not (action or adventure) from m;

/* I like action and adventure movies... */

/* in mysql, IF() function treats NULL as FALSE */
select title, if(action or adventure, 'fun','boring') as preference from m;
select title, if(not(action or adventure), 'boring','fun') as preference from m;
/* if you do not want this behavior use special condition IS NULL */
select title, if((action or adventure)is null, null,if(action or adventure, 'fun','boring')) as preference from m;

/* can add constants such as strings */
select 'movie', title, 'is',if(action or adventure, 'fun','boring') as preference from m;
select concat('I ',if(action or adventure, 'like ','do not like '), title, 'because it is ', if(action or adventure,
'fun', 'boring')) as preference from m;
/* can concatenate it all into a single string 

  CHECK OUT other STRING functions AT 
     https://dev.mysql.com/doc/refman/5.7/en/STRING-functions.html */
  /* note the reverse quote for column name */

/* === 5 DISTINCT === */
/* now let us turn to the u table describing users */
describe u;
select * from u;
/* what if we want the different values not the row listing? */
select occupation from u;
/* what are the occupations represented among the users? */
select distinct occupation from u;

  /* 19 different occupations */

/* same thing for ages */
select age from u;
select distinct age from u;

/* how about age and gender combo? */
select age,gender from u;
 /* 112 rows, one for each row in u, note two 26 M*/
select distinct age, gender from u;
/* now only unique combinations */
  /* only 48 rows, notice 26 M appears only once */

/* ==== 6 Selection of rows - Horizontal Slices ======== */
/* find movies with less than 120 minute running time */
select * from m;
select title, minutes from m where minutes <= 120;

/* can combine horizontal and vertical slices */
/* Find movie titles and running time in hours for movies lasting more than 2 hours */
select title, round(minutes/60,2) as hours from m where minutes/60 > 2;

/* find details on all movies that are not action movies */
select * from m where action = 0;
  /* note that null does not satisfy this condition */

select * from m where action = 0 or action is null;
/* find details on all movies where action is 0 or unknown */
/* note that null does not satisfy this */

select * from m where action and adventure = 1;
/* find details on all movies that are both action and adventure */

select * from m where action = 1 or adventure = 1;
/* find details on all action or adventure movies */
  /* NULL evaluates as NULL not true or false */
select * from m where (childrens and drama) = 1 or crime =1;
/* find details of all movies that are either childrens drama or a crime movie*/


/* find details of all movies that are not childrens movies */
select * from m where childrens = 0;
select * from m where childrens != 1;
select * from m where childrens <> 1;
