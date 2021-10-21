
# 실행할 때 단축키
# 한줄 실행 단축키 : ctrl + enter
# 전체 소스 및 선택 영역을 실행시키는 단축키 : ctrl + shift + enter

# shopdb 데이터베이스를 만든는 쿼리문
drop database if exists shopdb;      # shopdb가 만약에 존재한다면 날려라.
create database shopdb; 
# use명령어는 '~사용하겠다'
use shopdb;
# char(10) : 무조건 10바이트 할당해라. 10바이트 다쓰면 좋겠지만, 메모리의 낭비를 가져오는 경우가 대다수
# varchar(10) : 10바이트를 할당을 하긴 하는데 들어오는 데이터의 바이트수만큼만 쓰고 나머지는 사용할 수 
# 있는 메모리로 돌리는 것
# not null : 제약조건 중 하나인데, 값이 반드시 존재해야 한다는 제약조건이다.
drop table if exists membertbl;      # membertbl테이블이 만약에 존재한다면 날려라.
create table membertbl (
   memberID varchar(10) not null,
   memberName varchar(10) not null,
    memberAddress varchar(30),
    # PK도 제약조건의 일부인데 기본키라고도 한다.기본키가 있으므로 데이터의 중복은 절대로 일어나지 않는다.
    # 데이터의 무결성, 일관성, 중복방지를 할 수가 있다.
    primary key(memberID)      
);
# membertbl의 테이블 상태를 보는 명령어
desc membertbl;

# *의 의미는 테이블의 모든 컬럼을 다 가져와라는 의미
# membertbl에 있는 모든 열의 값들을 다 출력하는 쿼리문
select * 
  from membertbl 
 where memberID = 'shin' 
   and membername = '신은혁';
  
insert into membertbl values('shin', '신은혁', '대구광역시 달성군 현풍읍');
insert into membertbl values('dang', '신은혁', '대구광역시 달성군 현풍읍');
insert into membertbl values('Jee','지운이','서울 은평구 중산동');
insert into membertbl values('Han','한주연','인천 남구 주안동');
insert into membertbl values('Sang','상길이','경기 성남시 분당구');

#데이터를 삭제해주는 명령어(현업에서는 웬만하면 사용하지 마시라) 
delete from membertbl;         # 데이터 전체를 날리는 코드
# where memberID = 'shin';      # 조건절

# 만약에 producttbl이 존재하면 날려라.
drop table if exists producttbl;
create table producttbl(
   # primary key는 대표성, 유일성, 최소성도 만족하는 키, not null개념을 포함
   productName varchar(10) primary key,    
    cost int not null,
    makeDate date,      # 날짜 데이터 타입
    company varchar(10) not null,
    amount int not null    
);
desc producttbl;
insert into producttbl values('컴퓨터', 100, '2013-01-01', '삼성', 17);
# 다중으로 데이터를 저장하는 방법
insert into producttbl values
         ('세탁기', 200, '20170507', 'LG', 120),
            ('냉장고', 300, '20211001', 'LG', 120);
select *
  from producttbl;

-- show databases;
-- show tables;
-- show table status;







