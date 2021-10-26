use sqldb;

-- 순위 매기기 row_number() over()
-- 같은 키가 존재해도 순위를 정해버린다.
select row_number() over(order by height desc) as '키 순위', name '이름', addr '주소', height '키'
  from usertbl;
  
-- 같은 키가 존재하면 이름으로 순위 정해보기
select row_number() over(order by height desc, name asc) as '키 순위', name '이름', addr '주소', height '키'
  from usertbl;

-- rank() over(), 일반적으로 가장 많이 사용되는 순위함수 
-- 같은 키가 존재하면 동일한 등수로 만들고 동일한 등수의 수만큼 띄우고 순위를 정하기  
select rank() over(order by height desc) as '키 순위', name '이름', addr '주소', height '키'
  from usertbl;
  
-- dense_rank() over() 
-- 같은 키가 존재하면 동일한 등수로 만들고 동일한 등수의 수만큼 띄우고 않고 순위를 정하기
select dense_rank() over(order by height desc) as '키 순위', name '이름', addr '주소', height '키'
  from usertbl;

-- over(partition by 컬럼명), 컬럼명에 따라서 그룹지어서 그룹 안에서 순위를 정하기
select addr, name, height,
      rank() over(partition by addr order by height desc) as '지역별 키순위'
  from usertbl;

select addr, name, height,
      row_number() over(partition by addr order by height desc) as '지역별 키순위'
  from usertbl;

-- ntile(정수), 해당하는 row개수에 그룹으로 나누어주는 기능을 하는 함수, 그룹을 나눌 때, 실수값으로 나온다면 먼저 출력된 값에
-- 그룹을 더 많이 지정하는 경향을 볼 수가 있다.
select ntile(3) over(order by height desc) as '반 번호', name, addr, height
  from usertbl;

-- 분석 함수
-- lead(컬럼명, offset, default) : 현재 row를 기준으로 다음 행을 참조
-- default값은 원래 0이여야 하는데 제일 작은 키의 값을 알때 사용하면 일부러 if문을 사용할 필요가 없다.
select name, addr, height as '키',
      height - (lead(height, 1, 0) over(order by height desc)) as '다음 사람과의 키 차이'
  from usertbl;

select name, addr, height as '키',
      height - (lead(height, 1, 166) over(order by height desc)) as '다음 사람과의 키 차이'
  from usertbl;
  
-- lag(컬럼명, offset, default) : 현재 row를 기준으로 이전 행을 참조
select name, addr, height as '키',
      height - (lag(height, 1, 0) over(order by height desc)) as '이전 사람과의 키 차이'
  from usertbl;
  
select name, addr, height as '키',
      height - (lag(height, 1, 186) over(order by height desc)) as '이전 사람과의 키 차이'
  from usertbl;
  
-- 지역별 최대키와 차이
-- first_value(컬럼) : 정렬된 값 중에서 첫 번째 값을 의미한다.  
select addr, name, height as '키',
       height - (first_value(height) over(partition by addr order by height desc)) as '지역별 최대키와 차이'
  from usertbl;
  
-- last_value(컬럼) : 정렬된 값 중에서 맨 마지막 값을 의미한다.  
-- rows between unbounded preceding and unbounded following : 정렬 결과의 처음과 끝을 대상으로 함.
select addr, name, height as '키',
       height - (last_value(height) 
       over(partition by addr order by height desc rows between unbounded preceding and unbounded following)) as '지역별 최대키와 차이'
  from usertbl;
  
-- 누적 백분율 cume_dist() : 0 ~ 1사이를 리턴해준다.
select addr, name, height as '키',
       (cume_dist() over(partition by addr order by height desc)) * 100 as '누적인원 백분율'
  from usertbl;
-- 누적 백분율을 다 보기 위해서 아래와 같이 수정하였다.
update usertbl
   set height = 181
 where userid = 'LSG';

-- 간단한 피벗 테이블 만들어서 실습을 해보도록 하자.
drop table if exists pivot;
create table pivot (
   uname varchar(10),
    season varchar(5),
    amount int
);

insert into pivot values 
         ('김범수','겨울',10),('윤종신','여름',15),
         ('김범수','가을',25),('김범수','봄',5),
         ('김범수','봄',37),('윤종신','겨울',40),
         ('김범수','여름',14),('김범수','겨울',22),
         ('김범수','겨울',22),('윤종신','여름',64);

select *
  from pivot;

select uname,
      sum(case when season = '봄' then amount end) as '봄',
       sum(case when season = '여름' then amount end) as '여름',
       sum(case when season = '가을' then amount end) as '가을',
       sum(case when season = '겨울' then amount end) as '겨울'
  from pivot
group by uname;

-- 피벗 테이블을 만드는 두 번째 방법(sum(), if())
select uname,
       -- 만약에 season이 봄이면 amount을 sum을 해라.
       sum(if(season='봄', amount, 0)) as '봄',
       sum(if(season='여름', amount, 0)) as '여름',
       sum(if(season='가을', amount, 0)) as '가을',
       sum(if(season='겨울', amount, 0)) as '겨울'
  from pivot
group by uname;

select season,
      sum(if(uname='김범수', amount, 0)) as '김범수',
       sum(if(uname='윤종신', amount, 0)) as '윤종신',
       sum(amount) as '합계'
  from pivot
group by season
order by sum(amount)

-- 엑셀 데이터로 입출력 하는 import, export의 기능
select *
  from buytbl;
delete from buytbl;

-- 추출된 데이터를 엑셀 데이터로 내보내기를 하기 위해서 export클릭을 하면
-- .csv내보내기를 하고 아래 2가지 방법을 이용하여 글자깨짐을 방지토록 한다.
-- 첫 번째 방법
-- 1. 엑셀프로그램을 열고 데이터-텍스트를 클릭해서 가져올 데이터 csv파일을 
-- 가져오면 가져오는 형식이 뜨는데 UTF-8로 설정후 다음을 누르면 쉼표로 구분을 해주면 된다.
-- 2. 저장된 .csv파일을 메모장으로 열어서 다른이름으로 저장을 할 때, 인코딩을 ANSI로 설정
-- 후 저장을 하고 엑셀로 열면 된다.
-- 엑셀데이터를 테이블로 가져오기(import)를 하고자 한다면, MySQL은 UTF-8형태로 지원을 하니깐


