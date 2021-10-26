drop table if exists dept;
create table dept(
		id int not null,
        name varchar(10) not null
);

use sqldb;
select *
  from usertbl
 where name = "김경호";
 
select *
  from usertbl
 where name like "김%";
 
create table dept(
    deptno int not null,
    dname varchar(14),
    loc varchar(13),
    primary key(deptno)
);

insert into dept values 
			(10, '경리부', '서울'),
            (20, '인사부', '인천'),
            (30, '영업부', '용인'),
            (40, '전산부', '수원');
            
select *
  from dept;
  
create table emp(
    deptNo int,
    deptName char(10),
    job char(5),
    sal int,
    primary key(deptNo)
);

insert into emp values 
			(10,'인사팀','사원',250),
            (20,'재무팀','대리',300),
            (30,'법무팀','과장',350),
            (40,'영업팀','사원',250),
            (50,'설계팀','사원',500);
            
update emp
   set job = '사원'
 where sal = 250;
		