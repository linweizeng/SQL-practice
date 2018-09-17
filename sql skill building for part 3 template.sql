/* Skill Building for Part 3 */

/* Again, use the ecars database, the ones used and described in the earlier skill building exercise */
USE ecars;
select * from car;
select * from sales;
select * from state;
/* 1 find the total sales in each state by st code */
select st, sum(qty) from sales
group by st;
/* 2 In how many states have there been sales of ecars?  */
select count(distinct st) from sales;
/* 3 What is average sale for each model of ecar?  Round to integer 
only include those models that had sales in more than one state */
select model, round(avg(qty),0) as 'average sales',count(st) as 'no. of st' from sales
group by model
having count(st) > 1;

/* 4 find the maximum population of all blue states */
select color, max(pop) from state where color = 'blue'; 
/* 5 find the minimum population by color */
select color, min(pop) from state
group by color;
/* 6 same as above but only include those colors that have at least 2 states */
select color, min(pop), count(st) from state
group by color
having count(st)>=2;
/* 9 find the average MI (median income) and total population of states that have the letter a in their name */
select avg(mi) as'average median income', sum(pop) as 'sum of population' from state where name like '%a%';
/* 10 find the average population of states grouped by the second letter of their name 
include only those letters for which there are 2 or more states */
select avg(pop) as 'average population', substr(name,2,1) as 'letter',count(substr(name,2,1)) as'times' from state
group by substr(name,2,1)
having count(substr(name,2,1))>=2;
/* 11 how many cars have miles (range) provided and how many are missing?  
      order in acending count */
select count(model),if(miles is null,'null','not null') from car
group by if(miles is null,'null','not null');
/* 12 find the average range (miles column) of cars, giving nulls a value of 80 */
select avg(ifnull(miles,80)) from car;
select avg(miles) from car;

