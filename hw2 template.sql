/* Homework 2 on SQL
 * Again use the SPJ database */
use spj;jjjjp
select * from j;
select * from p;
select * from s;
select * from sp;
select * from spj;
/* Q1  get names of projects supplied by s1 */
/* first with subqueries */
select jname from j where jno in (select jno from spj where sno = 's1');
/* Q2 and again using joins */
select distinct jname from j join spj on j.jNO=spj.jNO
where spj.SNO = 's1';
/* Q3  get sno for suppliers who supply j1 and j2 */
/* first with subqueries */
select sno from spj where jno ='j1'and sno in (select sno from spj where jno='j2');
/* Q4 now with joins */
select distinct a.sno from spj a join spj b on a.sno=b.sno
where a.jno ='J1' and b.jno = 'J2';
/* Q5 Get pno values for parts supplied to any project by a supplier in the same city */
/* lets read this as p.city = s.city, other readings also ok */
/* first with joins */
select spj.pno,spj.sno,p.City,s.City from spj,p,s where spj.pno=p.pno and spj.sno=s.sno and p.City=s.City;

select distinct spj.pno from spj join p on spj.pno=p.pno join s on spj.sno=s.sno
where p.City=s.City;
/* Q6  now with subqueries */
select distinct pno from spj where concat(pno,sno) in (select concat(p.pno,s.sno) from p,s where p.City=s.CITY); 
/* Q7 Get jno values for projects supplied by at least one supplier not in the same city */
/* read as j.city not equal to at least one s.city where sno supplies jno */
/* with joins */
select distinct spj.jno from spj join s join j on spj.sno = s.sno and spj.jno = j.jno
where s.city != j.city;
/* Q8 with subqueries */
select distinct jno from spj where concat(jno,sno)
 not in (select concat(j.jno,s.sno) from j,s where j.City=s.CITY); 
/* Q9 Get sno values for suppliers supplying at least one part supplied */
/* by at least one supplier who supplies a red part */
/* with subqueries */
select distinct sno from spj where pno in (select pno from spj where sno in (select sno from spj where pno 
in (select pno from p where color = 'red')));
/* Q10. Get all pairs of city values such that a supplier in the first city
supplies a project in the second city */
select distinct s.city,j.city from spj join s on spj.sno=s.sno join j on spj.jno = j.jno where s.city !=j.city;