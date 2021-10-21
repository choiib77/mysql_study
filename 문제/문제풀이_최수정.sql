drop database if exists mydb;
create database mydb;
use mydb;

-- 문제 1
create table DEPTtbl(
	 DEPTNO int primary key,
	 DNAME varchar(14) not null,
	 LOC varchar(30)
);

-- 문제 2
insert into DEPTtbl values
					(10, '경리부', '서울'),
                    (20, '인사부', '인천'),
                    (30, '영업부', '용인'),
                    (40, '전산부', '수원');
                    

-- 문제3
drop table if exists EMPtbl;
create table EMPtbl(
	   deptNo int primary key,
       deptName char(10) not null,
       job char(5) not null,
       sal int not null
);

-- 문제4
insert into EMPtbl values
				   (10, '인사팀', '사원', 250),
                   (20, '재무팀', '대리', 300),
                   (30, '법무팀', '과장', 350),
                   (40, '영업팀', '사원', 250),
                   (50, '설계팀', '부장', 500);

-- 문제5
update EMPtbl
   set sal = 180
 where job = '사원';

select *
  from EMPtbl;

-- 문제6
delete from EMPtbl 
	  where deptName = '법무팀';
      
-- 문제7
create table videotbl (
	   video_id int auto_increment primary key,
       title varchar(20) not null,
       genre varchar(8) not null,
       star varchar(10)
);

-- 문제8
insert into videotbl values
			(null, '태극기휘날리며', '전쟁', '장동건'),
            (null, '대부', '액션', null),
            (null, '반지의제왕', '액션', '일라이저우드'),
            (null, '친구', '액션', '유오성'),
            (null, '해리포터', '환타지', '다니엘'),
            (null, '형', '코미디', '조정석');
            
-- 문제 9

select *
  from videotbl
  where star is null;
  
-- 문제 10
select *
  from videotbl
  where genre = '액션';
  
-- 문제 11
delete from videotbl 
	  where star = '유오성';
      
-- 문제 12
update videotbl
   set title = '동생'
 where star = '조정석';

-- 문제 13
delete from videotbl;

-- 문제 14
drop table if exists videotbl;

-- 문제 15
drop table if exists emptbl;
create table emptbl(
	   EMPNO int primary key,
       ENAME varchar(20) not null,
       JOB varchar(8) not null,
       MGR varchar(10),
       HIREDATE date not null,
       SAL int not null,
       COMM int,
       DEPTNO int,
       foreign key(DEPTNO) references DEPTtbl(DEPTNO) 
);
-- 문제 16
insert into emptbl values
			(1001, '김사랑', '사원', 1013, '2007-03-01', 300, NULL, 20),
            (1002, '한예슬', '대리', 1005, '2008-10-01', 250,  80, 30),
            (1003, '오지호', '과장', 1005,'2005-02-10', 500,  100, 30),
            (1004, '이병헌', '부장', 1008, '2003-09-02', 600, NULL, 20),
            (1005, '신동협', '과장', 1005, '2010-02-09', 450,  200, 30),
            (1006, '장동건', '부장', 1008, '2003-10-09', 480, NULL, 30),
            (1007, '이문세', '부장', 1008, '2004-01-08', 520, NULL, 10),
            (1008, '감우성', '차장', 1003, '2004-03-08', 500,  0, 30),
            (1009, '안성기', '사장', NULL, '1996-10-04', 1000, NULL, 20),
            (1010, '이병헌', '과장', 1003, '2005-04-07', 500, NULL, 10),
            (1011, '조향기', '사원', 1007, '2007-03-01', 280, NULL, 30),
            (1012, '강혜정', '사원', 1006, '2007-08-09', 300, NULL, 20),
            (1013, '박중훈', '부장', 1003, '2002-10-09', 560, NULL, 20),
            (1014, '조인성', '사원', 1006, '2007-11-09', 250, NULL, 10);

-- 문제 17
drop table if exists salgradetbl;
create table salgradetbl(
			GRADE int auto_increment primary key,
            LOSAL int not null,
            HISAL int not null
);

-- 문제 18
insert into salgradetbl values
			(null, 700, 1200),
            (null, 1200, 1400),
            (null, 1700, 2000),
            (null, 2000, 3000),
            (null, 3000, 9999);
            
-- 문제 19

select ENAME,SAL,HIREDATE
  from emptbl;
  
-- 문제 20
select EMPNO as '부서번호', ENAME as '부서명'
  from emptbl;
  
-- 문제 21
select distinct JOB
  from emptbl;
  
-- 문제 22
select EMPNO, ENAME, SAL
  from emptbl
 where SAL < 300;
 
-- 문제 23
select EMPNO, ENAME, SAL
  from emptbl
 where ENAME = '오지호';
 
-- 문제 24
select EMPNO, ENAME, SAL
  from emptbl
--  where SAL = 300 or SAL = 250;
 where SAL in(300, 250);

-- 문제 25

select ENAME
  from emptbl
 where SAL not in(300, 250,500);
 
-- 문제 26

select EMPNO, ENAME
  from emptbl
 where ENAME like '김%'
    or ENAME like '%기%';

-- 문제 27
select *
  from emptbl
 where JOB = '사장';
 

   
-- 문제 29

create table emp_copy(
	select *
      from emptbl
);
desc emptbl;

select *
  from emp_copy;

-- 문제 30
select ENAME, SAL,JOB
  from emp_copy
 where SAL>(
	select min(SAL)
      from emp_copy
	 where JOB = '과장')
  and JOB != '과장';
	