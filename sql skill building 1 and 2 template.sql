/* === Skill Building Part 1 and 2 ======
     Basic projection and selection
     Expressions and using built in functions
     NULLS
     String 
     Date
 ================*/    
 
USE ecars;

SHOW TABLES;  /* e-car database wiht tables car, sales, state */

DESCRIBE car;
select * from car;
   /* MODEL of car, MANufacturer, PRICE, BATTERY capacity in KWH, MOTORKW motor size in KW, 
      MPGE mpg equivalent, MILES range in miles, WEIGHT weight of vehicle in pounds, INTRO date of introduction */
      
DESCRIBE sales;
select * from sales;
   /* ST two letter state code, MODEL, QTY quantity sold in 2015 */
   
DESCRIBE state;
select * from state;
   /* ST state code, NAME name of state, POP population in millions, COLOR political color, MI median income in $K*/
   
/* 1 find manufacturers of ecars */
select man from car;

/* 2 find the model and weight of ecars, weight in tons, 1 ton = 2000 pounds, rouded to 2 decimals, column title 'ton' */
select model, weight,round(weight/200,2) as 'ton' from car;

/* 3 find model, manufacturer and hotness =  ratio of motor size in kw to weight in tons, indicating acceleration potential 
   round hotness to nearest integer */
select model, man,round(motorkw/(weight/2000),0) as 'hotness' from car;

/* 4 find details on all cars introduced in May 2014 */
/* do it using upper and lower limits for intro */
select * from car where intro>='2014-05-01' and intro<='2014-05-31';

/* 5 do it again using the month and year functions */
select * from car where year(intro)=2014 and month(intro)=5;

/* 6 which cars have null for miles?   report model */
select model from car where miles is null;

/* 7 which cars do not have null for miles?   report model */
select model from car where miles is not null;

/* 8 find the average mpg for cars */
select avg(mpge) as 'average mpg' from car;

/* 9 do the same assuming that value for miles is 0 if null  */
select avg(miles) from car;
select avg(if(miles is null, 0, miles)) as 'average miles' from car;
/* do this using the IF function */
/* why is this different from the previous average?  */

/* 10 now recompute the last average using IFNULL(), look this up on the web */
select avg(ifnull(miles,0)) from car;

/* 11 now turn to the sales table */
select * from sales;
/* find the st where ecars have been sold -- remove duplicates in report */
select distinct st from sales;

/* 12 find the st and model with 100 or more sold */
select st, model from sales where qty>=100;

/* 13 create a report where each row in the report reads like a sentence:
   99 units of leaf were sold in WA.
   try to copy the case/capitalizaton as I have it above  
   give the column a title 'Report on Sales' */
select concat(qty, ' units of ', lcase(model), ' were sold in ',ST,'.') as 'Report on Sales'from sales;

/* now turn to the state table */
select * from state;

/* 14 find the two letter state codes for states with the letter A in the name */
select st from state where name like '%A%';

/* 15 find the different colors of states that do not have the letter O in their name */
select distinct color from state where name not like '%o%';

/* 16 report on the two letter code and the first two letters of each states name
  the report will have the two letter code, the first two letters of state name, and a column titled SAME 
  with the value TRUE if the two letter code is the same as the first two letters of the state, FALSE otherwise 
  do it in two stes, first make a smaller report of just ST and the first two letters, then
  add the SAME column */
select st, substr(name,1,2) as 'st2', if(st = substr(name,1,2), 'TRUE','FALSE') as 'Same' from state; 
  
/* 17 find the names and colors of states where the second letter of the name is A */
select name, color from state where name like '_A%';

/* 18 find the names of states that begin or end with the letter O */
select name from state where name like 'o%' or name like '%o';
