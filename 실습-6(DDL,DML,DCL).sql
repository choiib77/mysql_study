-- 통상 sql은 아래와 같은 분류로 나뉜다.
-- 1.DML(Data Manipulation Language) : 데이터 조작언어
-- DML은 얼마든지 취소가 가능하다. rollback이란 키워드로 말이다.
-- ex) select, insert, delete, update
-- 2. DDL(Data Definition Laguage) : 데이터 정의언어
--  DDL은 취소가 안된다. 실해하면 바로 물리적 저장공간 바로 적용된다.
-- ex)create, drop, alter, truncate(테이블의 구조를 그대로 남긴체 데이터를 다 지워준다.)
-- 3. DCL(Data Control Language) : 데이터 제어언어
--  유저에게 어떤 권한을 부여하거나 빼앗을 때 사용하는 구문
--  ex)grant, revoke, savepoint

use sqldb;
drop table if exists testtbl1;
create table testtbl1(
	id int,
    username varchar(3),
    age int
);
insert into testtbl1(id, username, age) values(1,'홍길동',33);  -- 관례적으로 사용한다.
insert into testtbl1 values(1,'홍길동',33);						-- 테이블에 해당하는 내용을 전부 저장하고 싶을 때
insert into testtbl1(username, age) values('홍길동',33);			-- 원하는 컬럼에만 값을 넣고자 할 때

select *
  from testtbl1;
  
drop table if exists testtbl2;
create table testtbl2(
	-- auto_increment 구문은 DB(inno)엔진이 자동으로 행이 추가될 때 마다 1씩 증가된다.
	id int auto_increment primary key,
    username varchar(3),
    age int
);

insert into testtbl2 values 
	(null,'김철', 35),
    (null,'김군', 35),
    (null,'김군', 35);
    
select *
from testtbl2;

delete from testtbl2
 where id = 2;
-- 삭제하면 auto 2번 날라가는데 그거 매꿀려고 데이터 다시 insert 하지마라 빵꾸나면 난대로..두기..
insert into testtbl2 values(null,'김범',35);

-- auto_increment한 필드가 마지막으로 삽입된 것을 조회할 때는 last_insert_id()함수를
-- 이용하면 편리하다.
-- insert_id 개수
select last_insert_id();

-- 수정 auto_increment = 시작하고싶은 숫자
-- 테이블에 관련된 수정을 하고자 하면 alter를 이용하면 된다.
alter table testtbl2 auto_increment = 0;

drop table if exists testtbl3;
create table testtbl3(
	-- auto_increment 구문은 DB(inno)엔진이 자동으로 행이 추가될 때 마다 1씩 증가된다.
	id int auto_increment primary key,
    username varchar(3),
    age int
);

-- 아래 코드가 좀 생소하지만, 알아둘 필요가 있는 서버변수이다.
-- set구문 다음 @@붙으면 서버변수라고 생각을 하자.
-- 아래와 같이 코드를 줬다면 증가를 1씩하는게 아니라, 3씩 하게끔 설정을 하는 것이다.

set @@auto_increment_increment = 3;

insert into testtbl3 values
	(null,'나연',33),
	(null,'동수',30),
	(null,'은혁',14);
    
select *
	from testtbl3;

-- truncate구문 DDL이기때문에 트랜잭션에 해당하지 않기 때문에 대용량 데이터를 한번에
-- 지우고자할 때 truncate를 사용하는 것이 훨씬 효율적이다.
truncate testtbl3;
select *
	from testtbl3;
    
desc testtbl3;