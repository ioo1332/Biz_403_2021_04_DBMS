-- 현재 존재하는 DataBase를 보여달라
show databases;
-- 지금부터 MYSQL DataBase를 사용하겠다
-- 사용자와 연관이 없이 기본적으로 사용할 DataBase를 지정하여 사용할 준비
USE MYSQL;
-- 현재 접속한 DataBase(mysql)에 있는 모든 table을 보여달라
SHOW tables;
-- myDB라는 DataBase(데이터 저장소)생성
CREATE DATABASE myDB;
-- 생성된 저장소 확인 
SHOW databases;
-- MYSQL에서는 사용할 DB를 open하기
-- USE명령을 사용하여 DB open
USE myDB;
-- 현재 DB에 있는 모든 TABLE 을 보여달라
SHOW TABLES;
CREATE TABLE tbl_test(
	id BIGINT primary key AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    tel varchar(20),
    addr varchar(125)
);
SHOW tables;
-- MYSQL에서는 일련번호와 관련된 칼럼에 AUTO_INCREMENT 옵션을 설정하면
-- INSERT할때 값을 지정하지 않아도 자동으로 ID,SEQ값을 생성하여 칼럼에 추가하여준다
DESC tbl_test;
INSERT INTO tbl_test(name,tel,addr)
VALUES('홍길동','010-111-1111','서울시');
select*from tbl_test;

CREATE TABLE tbl_books(
	bk_isbn	CHAR(13)		PRIMARY KEY,
	bk_comp	VARCHAR(15)	NOT NULL,	
	bk_title	VARCHAR(125)	NOT NULL,	
	bk_author	VARCHAR(20)	NOT NULL,	
	bk_trnans VARCHAR(20)		,
    bk_date VARCHAR(10),
	bk_pages	INT		,
    bk_price	INT		
);
SHOW TABLES;
DESC tbl_books;
select *from tbl_books;
select count(*)
from tbl_books;
-- 도서가격이 2만원 이상인 데이터 
select *
from tbl_books
where bk_price >=20000;
-- 도서가격이 1만원이상 2만원 이하
select*
from tbl_books
where bk_price between 10000 and 200000;

select*
from tbl_books
where bk_price >= 10000 and bk_price <= 200000;

-- 도서명에 '왕'문자열이 있는 데이터
select *
from tbl_books
where bk_title like '%왕%';
-- java등 코딩에서 중간 문자열 검색
-- oracle 에서는 '%'||'왕'||'%'
-- mysql 에서는 concat('%','왕','%')
select*
from tbl_books
where bk_title 
like concat('%','왕','%'); 
-- 날짜 칼럼의 앞에 4글자만 보여줘라
select left (bk_date,4)
from tbl_books;
-- 발행일이 2018년인 도서들 찾기
select *
from tbl_books
where left (bk_date,4)='2018';
-- 전체 데이터를 날짜순으로 보여라
select *
from tbl_books
order by bk_date;
-- 도서명을 역순으로 정렬하여 보여라
select *
from tbl_books
order by bk_title desc;
-- 처음 3개 데이터만 보여라
select *
from tbl_books
limit 3;
-- 4번째 데이터부터 2개
-- 게시판 등 코딩에서 pageination 을 구현할때 사용하는 코딩
select *
from tbl_books
limit 3,2;

create database BookRent;
use BookRent;

create table tbl_books(
	bk_isbn	CHAR(13)		PRIMARY KEY,
	bk_title	VARCHAR(125)	NOT NULL,	
	bk_ccode	CHAR(5)	NOT NULL	,
	bk_acode	CHAR(5)	NOT NULL	,
	bk_date	VARCHAR(10)		,
	bk_price	INT		,
	bk_pages	INT		
);

create table tbl_company(
	cp_code	CHAR(5)		PRIMARY KEY,
	cp_title	VARCHAR(125)	NOT NULL	,
	cp_ceo	VARCHAR(20)		,
	cp_tel	VARCHAR(20)		,
	cp_addr	VARCHAR(125)	,	
	cp_genre	VARCHAR(10)		
);

create table tbl_author(
	au_code	CHAR(5)		PRIMARY KEY,
	au_name	VARCHAR(50)	NOT NULL	,
	au_tel	VARCHAR(20)		,
	au_addr	VARCHAR(125)		,
	au_genre	VARCHAR(30)			
);

create table tbl_buyer(
	bu_code	CHAR(5)		PRIMARY KEY,
	bu_name	VARCHAR(50)	NOT NULL	,
	bu_birth	INT	NOT NULL	,
	bu_tel	VARCHAR(20)		,
	bu_addr	VARCHAR(125)		
);

create table tbl_book_rent(
	br_seq	BIGINT		PRIMARY KEY auto_increment,
	br_sdate	VARCHAR(10)	NOT NULL	,
	br_isbn	CHAR(13)	NOT NULL	,
	br_bcode	CHAR(5)	NOT NULL	,
	br_edate	VARCHAR(10)		,
	br_prince	INT		
);