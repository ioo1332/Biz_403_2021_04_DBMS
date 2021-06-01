--testUser

CREATE TABLE tbl_books(
    bk_isbn	CHAR(13)		PRIMARY KEY,
    bk_comp	CHAR(5)	NOT NULL	,
    bk_title	nVARCHAR2(125)	NOT NULL	,
    bk_author	CHAR(5)	NOT NULL	,
    bk_date	VARCHAR(10)	NOT NULL	,
    bk_pages	NUMBER		,
    bk_price	NUMBER		
);
drop TABLE tbl_books;
CREATE TABLE tbl_company(
    cp_code	CHAR(13)		PRIMARY KEY,
    cp_name	nVARCHAR2(125)	NOT NULL	,
    cp_ceo	nVARCHAR2(30)	NOT NULL	,
    cp_tel	VARCHAR2(20)	NOT NULL	,
    cp_addr	nVARCHAR2(125)	NOT NULL
);
drop table tbl_company;
CREATE TABLE tbl_author(
    au_code	CHAR(5)		PRIMARY KEY,
    au_name	nVARCHAR2(125)	NOT NULL	,
    au_tel	VARCHAR2(20)		,
    au_addr	nVARCHAR2(125)		
);
drop table tbl_author;

-- 임포트된 데이터 확인
select count(*)FROM tbl_books;
select count(*)FROM tbl_author;
select count(*)FROM tbl_company;

--tbl_books 테이블에서 각출판사별로 몇권의 도서를 출판했는지 조회
select bk_comp,count(*)  
FROM tbl_books
GROUP BY bk_comp;

SELECT bk_comp AS 코드,cp_name AS 출판사명,count(*) AS 권수
from tbl_books B
    left join tbl_company C
        on B.bk_comp=C.cp_code
GROUP BY bk_comp,cp_name
ORDER BY bk_comp;

-- 1. tbl_books 테이블에서 도서가격이 2만원이상인 리스트
SELECT bk_price AS 가격,bk_title AS 제목
FROM tbl_books
WHERE bk_price>=20000;

-- 2. 도서가격이 2만원 이상인 도서들의 전체 합계금액
SELECT sum(bk_price)
FROM tbl_books
WHERE bk_price>=20000;

--tbl_books tbl_company tbl_author 세개의 talbe을 join 하여 
-- isbn, 도서명, 출판사명, 출판사대표, 저자, 저자연락처로 출력되록 sql작성
SELECT  B.bk_isbn AS ISBN,
        B.bk_title AS 도서명,
        B.bk_comp AS 출판사명,
        C.cp_ceo AS 출판사대표,
        A.au_name AS 저자,
        A.au_tel AS 저자연락처
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON B.bk_comp=C.cp_code
    LEFT JOIN tbl_author A
        ON B.bk_author=A.au_code;
 
-- 출판일이 2018인 데이터만
SELECT  B.bk_isbn AS ISBN,
        B.bk_title AS 도서명,
        B.bk_comp AS 출판사명,
        C.cp_ceo AS 출판사대표,
        A.au_name AS 저자,
        A.au_tel AS 저자연락처,
        B.bk_date AS 출판일
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON B.bk_comp=C.cp_code
    LEFT JOIN tbl_author A
        ON B.bk_author=A.au_code
    --WHERE bk_date BETWEEN '2018-01-01' and '2018-12-31';
    WHERE SUBSTR(B.bk_date,0,4)='2018';
/* SUBSTR(문자열칼럼,시작위치,개수)
    MYSQL:LEFT(문자열칼럼,앞에서몇개)
*/
CREATE VIEW view_도서정보 AS (
SELECT  B.bk_isbn AS ISBN,
        B.bk_title AS 도서명,
        B.bk_comp AS 출판사명,
        C.cp_ceo AS 출판사대표,
        A.au_name AS 저자,
        A.au_tel AS 저자연락처,
        B.bk_date AS 출판일
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON B.bk_comp=C.cp_code
    LEFT JOIN tbl_author A
        ON B.bk_author=A.au_code    
        );
SELECT * FROM "VIEW_도서정보"
WHERE SUBSTR(출판일,0,4)='2018';
/* 자주 사용할거같은 SELECT SQL은 view로 등록하면
    언제든지 사용이 가능하다
    
    그런데 자주사용할거같지 않은 경우 
    view생성하면 아무래도 저장공간을 차지하게 된다
    
    이럴때 한개의 SQL(SELECT)를 마치 가상의 table에
    
    
*/
SELECT*FROM(
SELECT  B.bk_isbn AS ISBN,
        B.bk_title AS 도서명,
        B.bk_comp AS 출판사명,
        C.cp_ceo AS 출판사대표,
        A.au_name AS 저자,
        A.au_tel AS 저자연락처,
        B.bk_date AS 출판일
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON B.bk_comp=C.cp_code
    LEFT JOIN tbl_author A
        ON B.bk_author=A.au_code    
)
WHERE SUBSTR(출판일,0,4)='2018';

-- tbl_books와 tbl_company ,tbl_author FK 설정
-- bk_comp와 cp_code  bk_author와 au_code

ALTER TABLE tbl_books --누구한테
ADD CONSTRAINT fk_comp -- fk이름
FOREIGN KEY (bk_comp) -- 누구의 칼럼
REFERENCES tbl_company(cp_code); --참조대상

ALTER TABLE tbl_books
ADD CONSTRAINT fk_author
FOREIGN KEY (bk_author)
REFERENCES tbl_author (au_code);
--pk
--개체 무결성을 보장하기위한 조건
--내가 어떤 데이터를 수정, 삭제할때
--수정하거나 삭제해서는 안되는 데이터는 유지하면서
--반드시 수정하거나 삭제하는 데이터는 수정,삭제가 된다
--수정이상, 삭제이상을 방지하는 방법
--중복된 데이터는 절대 추가될수 없다 : 삽입이상을 방지하는 방법

--fk
--두개 이상의 테이블을 연결하여 view(조회)를 할때 
--어떤 데이터가 null값으로 보이는것을 방지하기 위한 조치
--child(tbl_books):bk_comp  parent(tbl_comp):co_code
--있을수있고,추가가능      <<      있는코드
--있어서는안됨,추가불가능  <<      없는코드
--있는코드                  >>      코드삭제 불가능
--있는코드                  >>      반드시 있어야한다

--리처드 쇼튼의 연락처가 010-7270-5520에서
--010-9898-6428로 변경되었다
--리처드 쇼튼의 연락처를 변경해보기
UPDATE tbl_author
SET au_tel='010-9898-6428'
WHERE au_code='A0006';

--정보를 수정,삭제하는 절차
--내가 수정,삭제하고자하는 데이터가 어떤상태인지 조회
SELECT*FROM tbl_author
WHERE au_name='리처드 쇼튼';

--수정하고자 하는 리처드 쇼튼의 pk를 확인했다
--수정,삭제 하고자 할때는 먼저 대상 데이터의pk를 확인하고
--pk를 where절에 포함하여 update delete를 수행하자
UPDATE tbl_author
SET au_tel='010-9898-6428'
WHERE au_code='A0006';
--실무에서 update, delete를 2개이상 레고드에 동시에
--적용하는것은 매우 위험한 코드이다
--꼭 필요한 경우가 아니면 update,delete는 pk를 기준으로
--한개씩 수행하는것이 좋다