use ecars;
select MODEL, MOTORKW/WEIGHT as 'ap' from car order by ap desc;

select name, color from state join sales on sales.ST = state.ST
group by name, color
having avg(QTY)>50;

select name, color from state where st in (select st from sales
Group by st
having avg(qty)>50);

select color, avg(MI) from state where color like '%e'
group by color
order by avg(MI) desc;

select st, sum(QTY) from sales
group by st
having count(model) >=2;

select model, miles from car where mpge >= 85
order by battery/weight desc;