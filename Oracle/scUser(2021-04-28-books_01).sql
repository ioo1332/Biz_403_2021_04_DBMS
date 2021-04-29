--scUser 접속

DROP TABLE tbl_books_v2;
CREATE TABLE tbl_booksTable(
bt_code	NUMBER		PRIMARY KEY,
bt_publisher	NVARCHAR2(20)	NOT NULL,	
bt_bookname	NVARCHAR2(20)	NOT NULL	,
bt_writer	NVARCHAR2(20)	NOT NULL	,
bt_translator	NVARCHAR2(20)		,
bt_date	NCHAR(20)	NOT NULL	,
bt_page	NUMBER	NOT NULL	,
bt_price	NUMBER	NOT NULL	
);

INSERT ALL
INTO tbl_bookstable(bt_code,bt_publisher,bt_bookname,bt_writer,bt_translator,bt_date,bt_page,bt_price)
VALUES('9791162540770','비즈니스북스','데스바이아마존','시로타 마코토','신희원','2019-04-15','272','15000')
INTO tbl_bookstable(bt_code,bt_publisher,bt_bookname,bt_writer,bt_translator,bt_date,bt_page,bt_price)
VALUES('9791188850549','북라이프','4주만에 완성하는 레깅스핏 스트레칭','모리다쿠로','김현정','2019-04-11','132','13000')
INTO tbl_bookstable(bt_code,bt_publisher,bt_bookname,bt_writer,bt_date,bt_page,bt_price)
VALUES('9791188850518','북라이프','왕이된남자2','김선덕','2019-04-10','388','14000')
INTO tbl_bookstable(bt_code,bt_publisher,bt_bookname,bt_writer,bt_date,bt_page,bt_price)
VALUES('9791188850501','북라이프','왕이된남자','김선덕','2019-04-10','440','14000')
INTO tbl_bookstable(bt_code,bt_publisher,bt_bookname,bt_writer,bt_date,bt_page,bt_price)
VALUES('9791162540756','비즈니스북스','새벽에 읽는 유대인 인생특강','장대은','2019-04-10','280','15000')
SELECT*FROM DUAL;

CREATE TABLE tbl_books(
bk_isbn	CHAR(13)		PRIMARY KEY,
bk_comp	NVARCHAR2(15)	NOT NULL	,
bk_title	NVARCHAR2(125)	NOT NULL,	
bk_author	NVARCHAR2(50)	NOT NULL,	
bk_trans	NVARCHAR2(20)		,
bk_date	VARCHAR2(10)		,
bk_pages	NUMBER		,
bk_price	NUMBER		
);

--ALTER TABLE : TABLE을 변경하는 명령
--만들어진 TABLE의 이름 변경하기
ALTER TABLE tbl_books RENAME TO tbl_books_V2;
--이미 데이터가 담긴 테이블을 복제하기
--테이블구조와 데이터를 복제하여 백업을 하는 용도
--일부 제약조건이 함께 복제 되지 않는다
CREATE TABLE tbl_books AS SELECT*FROM tbl_books_V2;
--table을 복제한후 오라클에서는 반드시 pk를 다시 설정해줘야한다
--테이블을 생성하고 데이터가 있는상태에서 PK를 변경 추가 하는 경우는
--PK로 설정하려고 하는 칼럼의데이터가 PK조건 (유일성 NOT NULL)을 만족하지않는 데이터가있으면
--명령이 실패한다 대량의 데이터가저장된 테이블일 경우
--

ALTER TABLE tbl_books --tbl_books table 변경하겠다
ADD CONSTRAINT PK_isbn --제약조건을 추가하는데 이름을 pk_isbn
INVISIBLE PRIMARY KEY (bk_isbn); --isbn칼럼을 pk로 설정하겠다

ALTER tbl_books DROP PRIMARY KEY CASCADE;

/*도서정보를 저장하기 위해서 tbl_books테이블을 생성하고 도서정보를 import했다
도서정보는 어플로 만들기전에 사용하던 데이터인 관계로 
데이터베이스의 규칙에 다소 어긋난 데이터가 있다

저자 항목(칼럼)을 보면 저자가 2명이상인 데이터가 있고 또한 역자도 2명이상인 경우가있다

데이터를 저장할 칼럼을 크게 설정하여 입력(import)하는데는 문제가 없는데
저자나 역자를 기준으로 데이터를 여러가지 조건을 부여하여 조회하려고하면
문제가 발생할수있다 특히 저자이름으로 groupint 하여 데이터를 조회해보려고하면 어려움을 겪을수있다.
*/
DESC tbl_books;
--tbl_books테이블을 변경하라
--bk_author칼럼을 bk_author1으로 변경
ALTER TABLE tbl_books RENAME COLUMN bk_author TO bk_author1;
DESC tbl_books;
--bk_author2라는 칼럼을 생성하고 한글 가변 문자열2로 선언 NOT NULL로 설정하라
--ALTER TABLE을 이용하여 칼럼을 추가하는 경우에는 사전에 제약조건 설정이 매우 까다롭다
--제약조건을 설정하려면
--1.칼럼을 아무런 제약조건없이 추가한후
--2.제약조건에 맞는 데이터를 입력한후
--3.제약조건을 설정한다
ALTER TABLE tbl_books ADD bk_author2 nVARCHAR2(50);

SELECT *FROM tbl_books;

/*데이터베이스의 제 1정규화
한 칼럼에 저장되는 데이터는 원자성을 가져야한다
한 칼럼에 2개이상의 데이터가 구분자로(,)나뉘어서 저장되는것을 막는 조치
이미 2개이상의 데이터가 저장된 경우 분리하여 원자성을 갖도록 하는것이다
*/

/*도서정보 데이터의 제1정규화를 수행하고 보니 저자 데이터를 저장할 칼럼이 이후에
또 변경해야하는 상황이 발생할수있는 이슈가 발견되었다
제 2정규화를 통하여 데이터 테이블 설계를 다시 해야하겠다
1. 정규화를 수행할 칼럼이 무엇인가를 파악(인식)
저자 데이터를 저장할 칼럼 복수의 데이터가 필요한 경우
2. 도서정보와 관련된 저자데이터를 저장할 TABLE새로 생성
TBL_AUTHOR TABLE 생성예정
도서의 ISBN과 저자 리스트를 포함하는 형태의 데이터를 만들것이다
-----------
ISBN 저자
-----------
1    홍길동
1    이몽룡
2    성춘향
3    임꺽정
4    장영실
5    장녹수
-----------
*/

--도서의 저자 리스트를 저장할 TABLE 생성
CREATE TABlE tbl_book_author(
ba_seq	NUMBER		PRIMARY KEY,
ba_isbn	CHAR(13)	NOT NULL	,
ba_author	nVARCHAR2(50)	NOT NULL	
);

--tbl_books 테이블의 데이터를 삭제하고
--제1정규화가 완료된 데이터로 다시 import

DELETE FROM tbl_books;
commit;
SELECT*FROM tbl_books;
--제1정규화가 완료된 도서정보로 부터 저자리스트 생성
SELECT '('||bk_isbn,bk_author1 FROM  tbl_books
GROUP BY '('||bk_isbn,bk_author1
--두개 이상의 출력된 리스트를 합하여 1개의 리스트로 보여라
--각각의 조회 결과에서 나타나는 칼럼이 일치해야한다
UNION ALL 

SELECT '('||bk_isbn,bk_author2 FROM tbl_books
WHERE bk_author2 IS NOT NULL --bk_author2 데이터가 있는경우 보여달라
GROUP BY '('||bk_isbn,bk_author2;
--도서정보와 저자리스트를 JOIN 하여 데이터 조회
--저자가 1명인 경우는 한개의 도서만 출력이 되고
--저자가 2명인 경우는 같은 ISBN, 같은 도서명, 다른 저자 형식으로 
--저자 수만큼 출력 된다
SELECT bk_isbn,bk_title,ba_author
FROM tbl_books
LEFT JOIN tbl_book_author
ON bk_isbn=ba_isbn;
--제2 정규화가 완료된 상태에서 도서정보를 입력하면서 저자정보를 추가하려면
--저자 정보에는 isbn저자명을 포함한 데이터를 추가 해주면 된다

SELECT ba_author,bk_title,bk_title
FROM tbl_books
LEFT JOIN tbl_book_author
ON bk_isbn=ba_isbn
ORDER BY ba_author;

--정보처리기사
--제1정규화 : 원자성
--제2정규화 : 완전함수 종속성
--제3정규화 : 이행적함수 종속성

--tbl_book_author에 데이터를 추가하려고 할때
--9791162540572 이도서에 저자를 추가 하고 싶을때
--테이블의 ba_seq칼럼에는 이미 등록된 값이 아닌 새로운 숫자를 사용하여 데이터를 추가해야한다
--데이터를 추가할때마다 새로운 값이 무엇인지 알아야하는 매우 불편한 상황이 만들어진다

INSERT INTO tbl_book_author(ba_seq,ba_isbn,ba_author)
VALUES('35','9791162540572','홍길동');
INSERT INTO tbl_book_author(ba_seq,ba_isbn,ba_author)
VALUES('36','9791162540572','홍길동');
INSERT INTO tbl_book_author(ba_seq,ba_isbn,ba_author)
VALUES('37','9791162540572','홍길동');