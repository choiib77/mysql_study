use sqldb;
-- MySQL의 엔진은 어떤 문자셋을 사용하고 있는지 알기 위한 코드
-- UTF-8이라는 문자셋을 사용한다.한글이 3바이트로 설정되어 있다.
show variables like 'character_set_system';

-- cast()함수
-- 아래 cast문은 현재 문자열을 date 데이터 타입으로 캐스팅(변환)시켜준다.
select cast("2020-10-10 12:33:12:478" as date) '날짜'
  from dual;
  
select cast("2020-10-10 12:33:12:478" as time) '시간'
  from dual;
-- datetime데이터 타입은 문자형 데이터 타입으로 저장이 된다.  
select cast("2020-10-10 12:33:12:478" as datetime) '날짜와 시간'
  from dual;  

create table A(
   t datetime 
);  
-- mysql에서 지원하는 현재 날짜와 시각을 나타내주는 함수는 now(), sysdate()가 있다.
insert into A values(now());
insert into A values(sysdate());
select *
  from A;
-- mysql innodb가 함수나 명령을 실행할 수 있도록 제공 해주는 가상테이블, 더미(dummy)테이블  
select ceil(10.1)
  from dual;

-- timestamp타입 숫자형 데이터타입으로 저장됨 -- 4바이트
select timestamp(now());

-- 타임존(time-zone) - ex) ASIA/SEOUL, ASIA/TYOKO, AMERICA/LA 등
set time_zone = '+09:00';

drop table if exists timetbl;
create table timetbl(
   num int,
    date_timestamp timestamp not null,
    date_datetime datetime not null
);

SHOW VARIABLES 
WHERE variable_name LIKE '%time_zone%';

insert into timetbl values(1, now(), sysdate());
insert into timetbl values(2, now(), sysdate());
insert into timetbl values(3, now(), sysdate());
insert into timetbl values(4, now(), sysdate());

select *
  from timetbl;
-- @@global.time_zone : 데이터베이스 서버의 타임존
-- @@session.time_zone : 현재 연결되어진 세션의 타임존
select @@global.time_zone, @@session.time_zone;

-- UTC(세계표준 협정시)타임을 출력(GMT)
select utc_timestamp();

-- 변수
-- 이번에는 변수에 대해서 사용해 보고, 후반부 SQL프로그래밍에 변수가 
-- 많이 등장하므로 개념을 익힐 필요가 있다.
set @var1 = 5;
set @var2 = 3;
set @var3 = 5.77;
set @var4 = '이름 : ';

select @var1;
select @var1 + @var2;
-- 보기 좋게 출력하기 위해서 아래와 같이 변수를 사용해봄
select @var4, name
  from usertbl
 where height > 180;
 
-- 하지만, 변수는 limit절에는 못쓴다.
select @var4, name
  from usertbl
 where height > 170
 limit @var2;

-- prepare .. execute .. using문을 사용하면 된다.
-- 일단 아래 쿼리는 변수를 지정을 하고, myquery라는 명으로 ' '안에 있는
-- 쿼리문을 준비를 한다. ?는 변수명을 대입하고 execute문을 실행하는 것이다.
-- 예를 들어 응용SW에서 사용자로부터 입력을 받아서 출력한다면 이렇게 변수를 
-- 사용하면 좋을 것이다.중요한 부분이니 잘 정리를 해두도록 하자.
set @var1 = 3;
prepare myquery
   from 'select name, height
         from usertbl
       order by height
         limit ?';
execute myquery using @var1;


-- 아래 쿼리를 실행을 하면 buytbl의 amount평균을 나타낸다.
-- 하지만 소숫점을 반올림하고 싶을때는 cast, convert를 사용하면 된다.      
select avg(amount) as '평균구매갯수'
  from buytbl;
-- signed : 부호가 있는(음수, 양수)
-- unsigned : 부호가 없는(양수)
-- cast, convert함수를 쓰면 이것은 명시적 형변환에 속한다. 
select cast(avg(amount) as signed integer) as '평균구매갯수'
  from buytbl;

select convert(avg(amount), signed integer) as '평균구매갯수'
  from buytbl;
            
-- 문자열 연결 함수(concat())
select num, concat(cast(price as char(10)), '*', cast(amount as char(4)), '=') as '단가*수량',
       price*amount as '구매액'
  from buytbl;


-- 자바와 달리 아래 코드는 숫자형으로 변환되어 연산을 한다. cast(), convert() 미사용인데 연산이 이루어진다는 것은 
-- innodb가 알아서 바꿔주는 묵시적, 암시적, 자동형변환이라고 한다. 용어를 혼돈하지 말자.
select 100 + '100' + '-500';
-- select 100 + cast('100' as signed int);
-- concat()함수는 인자값으로 숫자가 들어있어도 문자로 묵시적 형변환이 일어난다.
select concat('100','원입니다');
select concat(100, '원입니다');