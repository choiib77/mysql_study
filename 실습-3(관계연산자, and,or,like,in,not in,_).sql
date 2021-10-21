use sqldb;
# 자기가 원하는 레코드를 풀력하고자 할 때는 될 수 잇으면, PK를 조건으로 명시하도록 하자.
select *
  from usertbl
where userid = 'KKH';
-- name컬럼에 있는 내용 중에서 '김경호' 인것만 레코드를 출력한다.

select *
  from usertbl
where name = '김경호';

-- 관계 연산자와 and를 이용하여 조건을 주었다.
-- and는 둘 다 참이여야만 참을 반환해준다.
-- 출생년도가 1970을 포함하여 그 이후의 조건과 키가 182이상인 조건을 둘다 만족하는
-- 데이터를 출력한다.
select *
   from usertbl
   where birthyear >= 1970
    and height >= 182;
    
-- 출생년도가 1970을 포함하여 그 이후의 조건과 키가 182이상인 조건을 둘 중의 하나르 ㄹ만족하는
-- 데이터를 출력한다.
select *
 from usertbl
where birthyear >= 1970
   or height >= 182;
    
-- 키가 180이상이고, 183이하인 조건을 충족하는 쿼리문 작성
select *
   from usertbl
    where height >= 180
    and height <= 183;
    
select *
   from usertbl
    where height between 180 and 183;
    
select *
 from usertbl
where addr = '경남'
   or addr = '전남'
   or addr = '경북'
   or addr = '전북';
   
-- in은 수치데이터(연속적인 데이터)가 아닌 이산적(떨어져있는)데이터에 사용된다.
-- 가독성이 위의 코드보다 좋다.
select *
  from usertbl
 where addr in ('경남', '전남','경북', '전북');
 
 -- 아래코드는 경남을 제외한 나머지를 출력하라.
select *
  from usertbl
 where addr not in('경남');