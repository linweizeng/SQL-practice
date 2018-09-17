/*  Now from multiple tables */

/* again using the ecars database */
USE ecars;
select * from car;
select * from sales;
select * from state;

/* For all sales, find the model, names of manufacturers, 
   names of states and the quantity shipped in descending order */  
select sales.model, man, name, qty from car, sales, state where car.model=sales.model and sales.st=state.st
order by qty desc; 
/* find cars and states where the price is less than the median income 
   joins can be quite varied and creative 
   the connections are totally up to you */
select car.model,name,price,mi*1000 mi from car join sales join state on car.model=sales.model and sales.st=state.st
where car.price <state.mi*1000;

select car.model,name from car join sales join state on car.model=sales.model and sales.st=state.st
where car.price <state.mi*1000;
/* for each car sale get the model and color of the state in which it is sold */
 select model,color from sales join state on sales.st=state.st;
/* find the models with no sales */ 
select car.model, qty from car left outer join sales on car.model=sales.model where qty is null;
 /* find the models and weight of cars with above average weight
   do it using joins not subqueries */
 select a.model, a.weight from car a, car b
 group by a.model
 having avg(a.weight)>=avg(b.weight);
  /*  now do it using subqueries */
  select model, weight from car where weight > (select avg(weight) from car);
 /* another example get names of all manufactures who have sold in OR 
  *  first using joins: */
 select distinct man from car join sales on car.model=sales.model where st = 'or';
 /* with subqueries
 always start with what you want reported */
 select distinct man from car where model in (select model from sales where st = 'or');
 /* find the manufacturers who have NOT sold in 'OR' */
  select distinct man from car where model not in (select model from sales where st = 'or');
select  * from car;