--여기는 bookuser접속

CREATE TABLE tbl_books(
bk_isbn	CHAR(20)		PRIMARY KEY,
bk_title	nVARCHAR2(50)	NOT NULL	,
bk_ccode	CHAR(5)	NOT NULL	,
bk_acode	CHAR(5)	NOT NULL	,
bk_date	VARCHAR2(10)		,
bk_price	NUMBER		,
bk_pages	NUMBER		
);
DROP TABLE tbl_books;

CREATE TABLE tbl_company(
cp_code	CHAR(5)		PRIMARY KEY,
cp_title	nVARCHAR2(125)	NOT NULL	,
cp_ceo	nVARCHAR2(20)		,
cp_tel	VARCHAR(20),
cp_addr	nVARCHAR2(125)		,
cp_genre	nVARCHAR2(30)		
);
DROP TABLE tbl_company;

CREATE TABLE tbl_author(
au_code	CHAR(5)		PRIMARY KEY,
au_name	nVARCHAR2(50)	NOT NULL,	
au_tel	VARCHAR(20)		,
au_addr	nVARCHAR2(125)	,	
au_genre	nVARCHAR2(30)		
);
DROP TABLE tbl_author;
--데이터 갯수로 임포트 확인
SELECT COUNT(*)FROM tbl_books;
SELECT COUNT(*)FROM tbl_company;
SELECT COUNT(*)FROM tbl_author;

SELECT bk_isbn AS ISBN,bk_title AS 도서명,C.cp_title AS 출판사명,C.cp_ceo AS 출판사대표,
    A.au_name AS 저자명,A.au_tel AS 저자연락처,bk_date AS 출판일,bk_price AS 가격
    FROM tbl_books B
        LEFT JOIN tbl_company C
            ON B.bk_ccode=C.cp_code
        LEFT JOIN tbl_author A
            ON B.bk_acode=A.au_code;
SELECT*FROM tbl_books;
/* 고정문자열 type 칼럼 주의사항 
char()type 의 문자열 칼럼은 실제 저자오디는 데이터 type에 따라 주의를 해야한다
만약 데이터가 숫자값으로만 되어있는경우 00001.00002와 같이 입력했을경우 
0을 삭제해버리는경우가 많다

(엑셀에서 import하는)실제 데이터가 날짜 타입일 경우 sql날짜형 데이터로 변환한후 
다시 문자열로 변환하여 저장

칼럼을 pk로 설정하지 않는 경우는 가급적 char로 설정하지말고 varchar2로 설정하는것이 좋다

고정문자열 칼럼으로 조회를 할때 아래와 같은 조건을 부여하면 데이터가 조회 되지않는 현상이 발생할수있다
where코드 = '00001'
*/
--도서정보 view만들기
CREATE VIEW view_도서정보 AS
(
SELECT bk_isbn AS ISBN,bk_title AS 도서명,C.cp_title AS 출판사명,C.cp_ceo AS 출판사대표,
    A.au_name AS 저자명,A.au_tel AS 저자연락처,bk_date AS 출판일,bk_price AS 가격
    FROM tbl_books B
        LEFT JOIN tbl_company C
            ON B.bk_ccode=C.cp_code
        LEFT JOIN tbl_author A
            ON B.bk_acode=A.au_code
);
 
SELECT*FROM view_도서정보;
--조건을 부여하여 찾기
--PK칼럼으로 데이터 조회
SELECT * FROM view_도서정보
WHERE isbn='9791162540527';
--도서명이 엘리트~ 로 시작하는 모든(LIST) 데이터 찾기
SELECT*FROM "VIEW_도서정보"
WHERE 도서명 LIKE '엘리트%';
--출판사명에 '넥' 문자열이 포함된 모든 데이터 찾기
SELECT*FROM "VIEW_도서정보"
WHERE 출판사명 LIKE '%넥%';
--출판일이 2018인 모든 데이터 찾기
SELECT*FROM "VIEW_도서정보"
WHERE 출판일 >='2018-01-01'  AND 출판일 <= '2018-12-31';
--출판일이 2018-01-01~2018-12-31인 모든 데이터 찾기
SELECT*FROM "VIEW_도서정보"
WHERE 출판일 BETWEEN '2018-01-01' AND '2018-12-31';
--SUBSTR()함수를 사용한 문자열자르기
--SUBSTR(문자열데이터,시작위치,개수)
--타 DB에서는 LEFT(문자열,몇글자)함수를 사용(오라클은 없음)
--RIGHT(문자열,몇글자)오른쪽에서 몇글자
SELECT*FROM "VIEW_도서정보"
WHERE SUBSTR(출판일,0,4)='2018';
 
--출판일 칼럼의 데이터를 앞에서 4글자만 잘라서 보여라
SELECT SUBSTR(출판일,0,4) AS 출판년도 FROM "VIEW_도서정보";
--출판일 칼럼의 데이터를 오른쪽으로 부터 4글자만 잘라서 보여라
SELECT SUBSTR(출판일,-5) AS 출판월일 FROM "VIEW_도서정보"; 
--1 or 1=1
--1인 결과가 있거나 1이거나
--sql injection 
DELETE FROM tbl_books 
WHERE bk_isbn= 1 or 1 = 1; 

