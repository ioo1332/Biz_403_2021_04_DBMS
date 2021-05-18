-- gbUser 접속 화면
show databases;
create database GuestBook;
USE GuestBook;
drop table tbl_guest_book;
create table tbl_guest_book(
	gb_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	gb_date	VARCHAR(10)	NOT NULL	,
	gb_time	VARCHAR(10)	NOT NULL	,
	gb_writer	VARCHAR(30)	NOT NULL,	
	gb_email	VARCHAR(30)	NOT NULL,	
	gb_password	VARCHAR(125)	NOT NULL,	
	gb_content	VARCHAR(2000)	NOT NULL	
);
insert into tbl_guest_book(gb_date,gb_time,gb_writer,gb_email,gb_password,gb_content)
values('2021-05-18','10:2:00','ioo','ioo@naver.com',12345,'오늘은 화요일');
select * from tbl_guest_book;
select count(*) from tbl_guest_book;
select * from tbl_guest_book
where gb_date='2021-05-18';

select * from tbl_guest_book
order by gb_seq desc;
-- 날짜와 시간기준으로 최근글이 제일 먼저 보이도록
select * from tbl_guest_book
order by gb_date desc, gb_time desc;
-- seq가 3번인 데이터 업데이트
-- update와 delete를 수행할때는 2개이상의 레코드에 영향이 미치는 명령은 신중하게 실행해야한다 
-- 가장 좋은 방법은 변경,삭제 하고자 하는 데이터가 여러개 있더라도
-- 가급적 pk를 기준으로 1개씩 처리하는것이 좋다
update tbl_guest_book
set gb_time='10:36:00'
where gb_seq=3;
select * from tbl_guest_book;

delete from tbl_guest_book
where gb_seq=1;
select * from tbl_guest_book;
rollback;

select 30*40;
-- mysql고유함수로 문자열을 연결할때 
select concat('대한','민국','만세');

select * from tbl_guest_book
where gb_content like '%오늘%';

select * from tbl_guest_book
where gb_content 
like concat('%','오늘','%');
-- oracle의 decode()와 유사한 형태의 조건연산
-- gb_seq의값이 값이 짝수면 짝수라고 표시
-- 아니면 홀수라고 표시
select if (mod(gb_seq,2)=0,'짝수','홀수')
from tbl_guest_book;

select floor(rand()*10);
select if(mod(floor(rand()*100),2)=0,'짝수','홀수');

select count(*)from tbl_guest_book;

select * from tbl_guest_book;

select * from tbl_guest_book
where gb_writer='기은성';

select * from tbl_guest_book
order by gb_date desc,gb_time desc;

select * from tbl_guest_book
where gb_content 
like '%국가%'
order by gb_date desc, gb_time desc;

create view view_방명록 as(
select gb_seq as '일련번호',
	gb_date as '등록일자',
    gb_time as '등록시간',
    gb_writer as '등록자이름',
    gb_email as '등록email',
    gb_password as '비밀번호',
    gb_content as '내용'
from tbl_guest_book
);    

select *from view_방명록;