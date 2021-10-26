use mydb;

-- 문제 52
select *
  from emptbl
 where substring(HIREDATE,6,2) = 09;
 
-- 문제 53
select *
  from emptbl
 where substring(HIREDATE,1,4) = 2003;
 
-- 문제 54
select *
  from emptbl
 where substring(ENAME,1,3) like "%기";
 
-- 문제 55
select abs(-44),abs(-77),abs(-100);

-- 문제 56
select cast("2015-09-01 11:22:44:777" as date) as "날짜"
  from dual;
  
-- 문제 57
select cast("2015-09-01 11:22:44:777" as time) as "시간"
  from dual;
  
-- 문제 58
select truncate(34.5678,0)
  from dual;
  
-- 문제 59
select round(34.5678,0)
  from dual;

-- 문제 60
select round(19.6678,1)
  from dual;
  
-- 문제 61
select truncate(24.4535,-1)
  from dual;
  
-- 문제 62
select mod(78,3)
  from dual;
  
-- 문제 63
select power(15,4), pow(3,4)
  from dual;
  
-- 문제 64
select rand()
  from dual;
  
-- 문제 65
select truncate(34.667788,2)
  from dual;
  
-- 문제 66
select upper('Welcome to MySQL'),lower('Welcome to MySQL')
  from dual;
  
-- 문제 67
select DATE_ADD("2017-10-05", interval 30 day),DATE_ADD("2017-10-05", interval 1 month)
  from dual;
  
-- 문제 68
select date_sub("2017-10-05", interval 30 day),DATE_sub("2017-10-05", interval 1 month)
  from dual;
  
-- 문제 69
select DATEDIFF(now(),'1992-12-03') 
  from dual;
  
-- 문제 70
-- ???

-- 문제 71
-- ???

-- 문제 72
select TIME_TO_SEC('09:45')
  from dual;
  
-- 문제 73
-- ??

-- 문제 74
select QUARTER(now())
  from dual;