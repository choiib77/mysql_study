select *
  from employees.employees;
  
drop table if exists testtbl4;
create table testtbl4(
   id int,
    fname varchar(20),
    lname varchar(20)
);

desc employees.employees;

-- testtbl4에 대용량 데이터를 바로 삽입하는 코드
insert into testtbl4
   select emp_no, first_name, last_name
     from employees.employees;
-- 테이블을 만들면서 바로 select를 이용하는 것이다.      
drop table if exists testtbl5;
create table testtbl5(
   select emp_no, first_name, last_name
     from employees.employees
);  
drop table if exists testtbl6;
create table testtbl6(
   select emp_no, first_name, last_name
     from employees.employees
);  
-- 테이블을 만들면서 알리아스를 주어 원하는 컬럼명으로 하는 것이다.
drop table if exists testtbl7;
create table testtbl7(
   select emp_no as id, first_name as Fname, last_name as Lname
     from employees.employees
);  
select *
  from testtbl7;

drop table testtbl4;
delete from testtbl5;
truncate testtbl6;

-- 성이 Kyoichi가 무려 251건이 나옴
select *
  from testtbl4
 where fname = 'Kyoichi';


-- 이제는 update구문을 대해서 알아보도록 하자
-- update...set..where형태로 쓴다.
-- 만약 where(조건절)가 없다면, 모든 데이터를 수정해버린다. 현업에서도 상당한 실수가 잦다.
-- 주의를 기울이자.
update testtbl4
   set lname = '없음'
 where fname = 'Kyoichi';

-- TCL(Transaction Control Language) : 트랜잭션을 컨트롤 해주는 언어(DML 구문에만 적용되는 것)
rollback;   -- commit하기 전 상태라면, 잘못된 부분이 있다면 다시 원복시킨다.
commit;      -- 물리적으로 완전 저장(디스크), 다시는 롤백이 되지 않는다.
-- 아래 코드는 오토커밋 상태를 확인하는 쿼리이며, 결과가 0이면 수동으로 커밋을 해야되고, 1이라면 오토커밋 상태인 것이다.
SELECT @@AUTOCOMMIT;
set @@AUTOCOMMIT = 1;

select *
  from buytbl;

-- 간혹 가다가 전체를 대상으로 update치는 경우도 있다.
-- 제품 단가가 올라다던지, 아니면 월급이 5% 인상이 되었다던지 등등
-- where절이 필요가 없다.
update buytbl
   set price = price * 1.2;
   
select *
  from testtbl4
 where fname = 'Aamer';
 
-- delete문에서도 역시 where가 없다면 모든 데이터를 다 지우는 것이다.
-- where절을 반드시 넣도록 한다.
delete from testtbl4
 where fname = 'Aamer';



