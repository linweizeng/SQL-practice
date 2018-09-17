/* Names of team members - Linwei Zeng / Chenqian Zhong / Zitong Yang / Wanxuan Xu / Qiao Zeng / Bohao Dong */

/* use database spj 
    relation s describes suppliers
       sno = supplier number, sname = supplier name, status = status level of supplier, 
       city = location of supplier, phone = phone number, site = web site url
    relation p describes parts supplied by suppliers
       pno = part number, pname = part name, color = color of part, weight = weight in pounds, city = location of part 
    relations j describes projects
       jno = project number, jname = project name, city = project location 
    relation spj describes shipments of parts by suppliers for a particular project 
    ignore relation sp for now (it is simpler version of spj) 
    we are going to use just the s table for this assignment */
use spj;

/* Q1: (10 point) Find the names and sites of suppliers with status greater than 20 and city name contains letter i */
select * from s;
select sname,site from s where status>20 and city like '%i%';
/* Q2: (10 points) Find the top level domains (tld) used by suppliers 
    com, au, info are examples of tld, it is the LAST part of the url
    use the substring_index() function */
select sname, substring_index(site,'.',-1) as 'tld' from s;
/* Q3: (20 points) Find the area code of the phone numbers of all suppliers
  the area code is the part within the parenthesis
   use only the substring_index() function 
   use the column name Area Code for the report */
select sname, substring_index(substring_index(phone,')',1),'(',-1) as 'Area Code' from s;
/* Q4: (10 points) Now use what you learned in the previous two queries to answer the following query:
   Find the tld of all suppliers in teh 201 area code   
   use only substring_index() function */ 
select sname, substring_index(site,'.',-1) as 'tld' from s where substring_index(substring_index(phone,')',1),'(',-1) in ('201');
/* Q5: (50 points) now again find the tld
    this time do it using substr() and locate() and other string functions but do NOT use substring_index()  */
select sname, substr(substr(site,-4),locate('.',substr(site,-4))+1) as 'tld' from s;
/* Q6: (40 points) now again find the area code 
       use only the substr() and locate() functions, do not use any other functions */
select sname,substr(phone,(locate('(',phone)+1), (locate(')', phone) - locate('(', phone) - 1)) 'area code' from s;

/* Q7 (20 Points) Find the names of suppliers where l is the second character or the s is the last character in the name */
select sname from s where sname like '_l%' or sname like '%s';
/* Q8 (40 Points) find the names, and the number of days to current day for which each supplier has been qualified
   output 0 if the date is unknown */
select sname, if((qual_date)is null, 0, datediff(current_date , qual_date)) as 'qualified date' from s;
/* 200 points total
   save your query file with a sql extension
   all non-sql parts must be as comments
   add the name of your team members as comments at the top of the file
   save and upload in blackboard, one per team */
