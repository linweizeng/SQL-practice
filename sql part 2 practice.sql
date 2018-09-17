/* === 3 now for some matching using LIKE ==== */
/* ==================== LIKE ===============================*/
/* SQL has rudimentary pattern matching for strings using the LIKE function
patterns are composed of characters, which stand for themselves,
and two wildcard characters:
  wildcard _ (underscore) stands for exactly one character
  wildcard % (percentage) stands for 0 or more characters
  wildcards vary among database systems */
use movielens;
select * from m;
/* find the names of all movies that start with the letter t */
select title from m where title like 't%';
/* note - NOT case sensitive   */

/* find all the occupations in u that end with r */
select * from u;
select distinct occupation from u where occupation like '%r';
/* find all the occupations in u that startwith e end with r */
select distinct occupation from u where occupation like 'e%r';

/* find all the occupations in u that have the substring er in them */
select distinct occupation from u where occupation like '%er%';
/* find all the occupations in u that have leter h in them  and are shorter than 6 letters */
select distinct occupation from u where occupation like '%h%' and length(occupation)<6;
/* find all titles of movies in m where the second letter is an o */
select title from m where title like '_o%';

/* find all titles of movies in m where the second letter is NOT an o */
select title from m where title not like '_o%';

/* find all titles that have a three lettered word in the title */
select title from m where title like '___ %' or'% ___' or '% ___ %' or '___';

/* 4 ===== Date and Time ======= 
See https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html
   for date and time functions in MySQL */

/* find ALL reviews IN 1998 */
select * from r;
select * from r where year(ts)=1998;
/* see also date(), day(), month(), time() */ 

select * from r where ts>= '1997-11-30' and ts<='1998-01-14';
select * from r where ts>= str_to_date('NOV-30-1997', '%b-%d-%Y') and ts<= str_to_date('14/1/98','%d/%m/%y');

/* find all reviews from NOV-30-1997 to 14/1/98. see google date_format */


/* or */


/* find all reviews within 10 days of 1-JAN-1998 */
select * from r where ts>= '1998-01-01' and ts<=adddate('1998-01-01',10);
select * from r where ts>= subdate('1998-01-01',10) and ts<=adddate('1998-01-01',10);
select * from r where ts>= adddate('1998-01-01',-10) and ts<=adddate('1998-01-01',10);
/* or */




