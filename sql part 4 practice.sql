USE jex;
/*  Now from multiple tables, select all from course, roster,course and roster,3,5,15 */
select * from course;
select * from roster;
select * from roster, course;

/* not all combinations of the two relations makes sense
a natural connection between the two is to have the cid match
this is a natural join of the two tables, merge 2 tables. where, join */
 /*note the use of relation name to identify the attribute */
/* another way to write this, that is more transparent is: */
select * from course join roster on course.cid = roster.cid;
select * from course, roster where course.cid=roster.cid;
/* Who is enrolled in course with cid 'A' .select student ID with cid A*/
select sid from roster where cid = 'a';

/* Who is enrolled in Analytics? 
now we need to use two tables and a join */
select sid from roster join course on course.cid=roster.cid where cname = 'Analytics';
select sid from roster, course where course.cid=roster.cid and cname = 'Analytics';
select sid from roster where cid in (select cid from course where cname = 'Analytics');
/* Find all details of courses in which student 3 is enrolled?  */
select * from roster, course where course.cid=roster.cid and sid = 3;
select * from roster join course on course.cid=roster.cid where sid =3; 

/* what happened to course E in which student 3 is enrolled?  

 What if we want all courses, even those with no extra details?
 We need a JOIN that does NOT throw away the mismatched rows 
 [LEFT|RIGHT] OUTER JOIN
 */
SELECT * FROM roster LEFT OUTER JOIN course ON roster.cid=course.cid;
select * from course right outer join roster on roster.cid=course.cid;

/* find course names */
select cname from course;

/* find course names and sid of enrolled students,ordered by course name*/
select cname,sid from course join roster on roster.cid=course.cid
order by cname;

select cname,sid from course, roster where roster.cid=course.cid
order by cname;
/* what happened to course C which has no students, I want that in the list as well,order by course name */
/* or using RIGHT OUTER JOIN */
/* what happened to course C which has no students, I want that in the list as well */

select cname,sid from course left outer join roster on roster.cid=course.cid
order by cname;
select cname,sid from roster right outer join course on roster.cid=course.cid
order by cname;


















/* now lets turn back to the movielens database,select all from m and r */
USE movielens;
select * from m;
select * from r;
/* find the movie name and average rating for each movie,order by rating */
select title, avg(rating) avr from m, r where m.movieid=r.movieid
group by title
order by -avg(rating);

select title, avg(rating) from m join r on m.movieid=r.movieid
group by title
order by -avg(rating);
/* same as above but only including users whose age is 21 or younger,order by decreasing rating */
select title, avg(rating) from m join r join u on m.movieid=r.movieid and r.userid=u.userid
where age<=21
group by title
order by avg(rating) desc;

select title, avg(rating) avg_rating from m,r,u where m.movieid=r.movieid and r.userid=u.userid
and age<=21
group by title
order by avg(rating) desc;

/* same as above but only including users whose age is 21 or younger,order by decreasing rating */
/* same as above, in decreasing order of average rating */
select title, avg(rating) avg_rating from m join r on m.movieid=r.movieid join u on r.userid=u.userid
where age<=21
group by title
order by avg_rating desc;

/* find the average rating by all users in zipcodes starting with 0 or 1 */
select avg(rating) from r where userid in (select userid from u where zip like '0%' or zip like '1%'); 
select avg(rating) from r join u on r.userid=u.userid where zip like '0%' or zip like '1%';
/* find the average rating by zone, zone defined by first letter of zip code*/
select avg(rating) avg_rating, substr(zip,1,1) zone from r,u where r.userid=u.userid
group by zone;
select avg(rating) avg_rating, substr(zip,1,1) zone from r join u on r.userid=u.userid
group by zone;

 /* another example
 Get the names of movies rated by userid 1 */
select title from m join r on m.movieid=r.movieid where userid=1;
select title from m,r where m.movieid=r.movieid and userid=1;
 /*  === SUBQUERIES ==== 
 ... now using subqueries...
 start with what you want to report from which table
 then build the condition using subqueries */

 /* yet another example -- find the names of movies that 
 have received the highes rating 5 from any user*/
select title from m where movieid in (select movieid from r where rating=5);
 
 /* find the names of all movies that have received a 5 from a user in zone 0, order by title */
select title from m where movieid in(
select movieid from r where rating=5 and userid in(
select userid from u where zip like '0%'))
order by title;
 
 /* do the same thing using joins */
select distinct title from m join u join r on m.movieid=r.movieid and r.userid=u.userid
where rating=5 and zip like '0%';
  
 /* find the average duration of movies */
select avg(minutes) from m;
/* find movies with above average duration */
select title from m where minutes>108.0909;
/* with manual intervention */

/* we want to automate this, no manual interventions should be used */
select title, minutes from m where minutes >= (select avg(minutes) from m);

/* can be done with joins but not easy 
  * start with creating a cartesian product of the table m as a and m as b
  * group by m.title
  * report only those wiht avg(a.minutes) >= avg(b.minutes)
  * why does this work? */
select a.title,avg(a.minutes)from 
m a, m b
group by a.title
having avg(a.minutes) > avg(b.minutes);


  
 /* could also use avg(a.minutes) >= min(b.minutes) why? */
 
 /* subqueries are much easier */
select title,minutes from m where minutes >= (select avg(minutes) from m);
 /* anotehr example where subqueires are much easier...
      find the titles of movies not reviewed by userid 1 */



  
 /* notice that it picks up Toy Story 2 that has not been reviewed by any one */