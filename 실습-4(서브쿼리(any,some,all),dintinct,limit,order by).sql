use sqldb;
-- 서브쿼리는 쿼리문 안에 또 다른 쿼리문이 있는 것을 의미한다.
-- 아래 코드는 키가 177초과되는 데이터를 출력한다.
-- 김경호의 키가 177을 알고 있을 때는 아래 코드로 사용할 수 있는 쿼리가 된다.
-- 그런데 우리가 김경호라는 이름만 알고 키를 모른다면 과연 어떻게 해야 할까?
-- 이 때 서브쿼리를 이용을 적절히 해주면 된다.
select name, height
  from usertbl
 where height > 177;

-- 아래는 서브쿼리를 작성해서 위와 같이 동일한 결과를 출력한다.
--  실행순서는 먼저 서브쿼리를 실행하고 그 결과값을 가지고 메인쿼리(상위쿼리)실행된다.
--  서브쿼리의 결과값은 177인 것을 알 수가 있다.
select name, height
  from usertbl
 where height > (
      select height
          from usertbl
       where name = '김경호');
         
select *
  from usertbl;         
 -- 아래 쿼리문을 실행 해보면 에러가 발생한다. 그 이유는 서브쿼리의 결과 값이
 -- 반드시 1개여야지만 비교대상이 된다.서브쿼리의 결과값이 2개 나왔다라는 것은
 -- 비교대상의 모호성이 발생한다.에러가 발생한다.하여 서브쿼리의 결과는 항상 1개
 -- 이어야 한다.
select name, height
  from usertbl
 where height > (
      select height
          from usertbl
       where addr = '경남'); 
         
-- 위의 코드에다가 서브쿼리 앞에 any를 붙였다.
-- 서브쿼리의 결과값이 170, 173이었다. 서브쿼리 앞에 any의
-- 의미는 or의 개념과 비슷하다.170이거나 173이다. 즉, 다시말해
-- 170이상인 데이터를 다 출력하겠다라는 의미가 되는 것이다.
-- 기억할 것은 서브쿼리가 반환하는 값은 키(height)라는 것이다.
select name, height
  from usertbl
 where height > any (
      select height
          from usertbl
       where addr = '경남'); 
-- any나 some은 동일한 기능을 한다. 
select name, height
  from usertbl
 where height > some (
      select height
          from usertbl
       where addr = '경남'); 
         
-- all은 서브쿼리의 결과 값 둘 다 만족하는 데이터만 출력한다.
-- 즉, 170, 173 다 만족하는 값은 173인 것이다.          
select name, height
  from usertbl
 where height > all (
      select height
          from usertbl
       where addr = '경남'); 
         
-- 부등호를 바꾸면 170,173과 똑같은 결과값만 리턴하고 있다.          
select name, height
  from usertbl
 where height = any (
      select height
          from usertbl
       where addr = '경남');   

-- 위의 코드를 in()를 사용해서 바꿔본 쿼리문이다.
select name, height
  from usertbl
 where height in(
      select height
          from usertbl
       where addr = '경남');   

-- 정렬에 대해서 알아보도록 하자.
-- 기본적으로 order by절을 사용하게 된다. 오름차순(asc)으로 정렬이 된다.
select *
  from usertbl
order by addr desc;
         
-- order by절을 적절히 잘 이용을 하면 보기 좋게 정렬을 하기 때문에
-- 데이터의 가독성이 높아진다.      
-- 기본적으로 order by절을 사용하게 된다. 오름차순(asc)으로 정렬이 된다. 
-- desc는 내림차순을 의미한다. 반드시 desc는 생략 불가능하다.  
select *
  from usertbl
order by addr desc, mobile1 asc; 

-- 데이터가 중복될 때 사용할 수 있는 키워드가 바로 distinct키워드이다. 
-- 현업에서 정말 쓰는 키워드이니깐 반드시 기억하도록 노력하자.
select distinct addr
  from usertbl;
  
use employees;
-- limit을 쓰지 않고 출력을 하면 30만건을 다 조회해서 가져와서 쿼리를 
-- 실행하니 비효율적이다.
-- 하여 limit키워드를 적절히 이용한다면 좋을 것이다.
select *
  from employees
order by hire_date
-- limit 10;
limit 1000, 5; -- 좌측처럼 하면 1000번째 부터 5명을 출력해라. 

-- 알리아스(별칭)
select emp_no as '사원번호', gender as '성별'
  from employees;