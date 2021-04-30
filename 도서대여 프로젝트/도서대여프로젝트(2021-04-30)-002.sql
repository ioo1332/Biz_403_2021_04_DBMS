--bookuser 접속
--books Table과 author, company table은 relation관계가 있다
--  books의 bk_ccode와 company의 cp_code
--  books의 bk_acdoe와 company의 au_code
--연관관계에 있는 Table을 EQ JOIN을 실행할때
--만약 author, company, table에 없는 데이터(코드)가 books에 있다면
--EQ Join을 하면 데이터가 누락되어 버린다
--또한 LEFT Join을 하면 값이 null로 출력된다
--Join된 데이터가 누락되거나 null로 출력되는것은 데이터에 문제가 발생한것이다
--참조 무결성이 무너졌다라고 한다
SELECT*FROM "VIEW_도서정보";

SELECT* 
FROM tbl_books,tbl_author,tbl_company
WHERE bk_ccode=cp.code AND bk_acode=au_code;

--다수의 table이 연관 관계에 있을때 join 한 결과가 잘못되면 
--DB신뢰성에 매우 큰 문제가 발생한다
--Relation설정이된 table간에 참조무결성을 보장하기위한 제약조건을 설정할수있다
--이 제약조건을 FOREIGN KEY(외래 키)설정이라고 한다

--tbl_books와 tbl_company를 참조 무결성 설정
--tbl_company의 PK를 참조하여 tbl_books 데이터에 출판사 정보를 연동
--tbl_company를 parent라고 하고 REFERNCES table이라고 한다
--FK를 설정하는 대상은 child table인 tbl_books가 된다
ALTER TABLE tbl_books --FK를 설정할 테이블
ADD CONSTRAINT fk_company --FK 이름 설정
FOREIGN KEY (bk_ccode) -- FK를 설정할 칼럼은 (child칼럼)
REFERENCES tbl_company(cp_code); --누구하고? parent table (칼럼)

ALTER TABLE tbl_books
ADD CONSTRAINT fk_author
FOREIGN KEY(bk_acode)
REFERENCES tbl_author(au_code);
--만약 tbl_books table의 bk_acdoe칼럼에 저장된 데이터를 삭제하려고하면
--오류가 발생하고 데이터가 삭제되지 않아야 한다
DELETE FROM tbl_author
WHERE au_code='A0002';
--A0002삭제됨
INSERT INTO tbl_books(bk_isbn,bk_title,bk_acode,bk_ccode)
VALUES('970001','테스트','A0002','C0001');
/*
=======================================
tbl_books.bk_acode   tbl_author.au_code
---------------------------------------
코드가 있으면   >>   반드시 있어야 한다
있을수 있음     <<   코드가 있으면
절대 있을수없음 <<   코드가 없으면
코드가 있으면   >>   삭제 불가능
코드가 있으면   >>   코드값 변경 불가
---------------------------------------
*/
--FK삭제
ALTER TABLE tbl_books
DROP CONSTRAINT fk_author;
DELETE FROM tbl_author
WHERE au_code='A0001';

--데이터가 입력된 table간에 FK를 설정하려고 할 경우
--모든 데이터가 참조 무결성에 유효한지 검토하고 데이터가 문제가 있을경우
--문제를 해결한후 FK설정이 가능하다
--parnet 테이블에 데이터를 추가하거나 child데이터를 삭제하는 방법이 있다
ALTER TABLE tbl_books
ADD CONSTRAINT fk_author
FOREIGN KEY(bk_acode)
REFERENCES tbl_author(au_code);

INSERT INTO tbl_author(au_code,au_name)
VALUES('A0002','삭제된저자');
--FK가 설정된 상태에서 parents 테이블에 데이터가 잘못입력된것이 발견되어
--데이터를 삭제하고자 한다 하지만 이미 사용된 (books에 등록된) 데이터는 삭제가 불가능하다
--그러한 제약사항을조금 약하게 하는 방법이 있다
--parents 데이터를 삭제하면 연관된 테이블의 데이터를 같이 삭제하거나 
--코드가 변경되면 연관된데이터의 코드값을 변경하거나
ALTER TABLE tbl_books
ADD CONSTRAINT fk_author
FOREIGN KEY(bk_acode)
REFERENCES tbl_author(au_code)
ON DELETE CASCADE;