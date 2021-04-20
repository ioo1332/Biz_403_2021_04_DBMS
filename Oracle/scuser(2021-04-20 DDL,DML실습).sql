-- 여기는 scuser로 접속한 화면
-- scuser는 DBA권한을 가지고있으며
-- 데이터를 저장하기위한 TABLE을 만들고
-- 데이터를 추가,조회,수정,삭제 실습하기

-- TABLE 
-- DBMS를 사용하여 데이터를 추가하면
-- 마치 excel sheet에 데이터를 저장하는것처럼 데이터가 저장된다
-- 실제 DBMS 소프트웨어가 저장한느 방식은 고유한기술이 적용되어 있지만
-- DBMS 소프트웨어를 사용하는 사용자는 모든 데이터는 표(table)형식으로 
-- 저장된것으로 인식하는 표준 형식이다
-- Oracle 데이터 저장구조: TableSpac>Table>데이터들
-- TABLE은 Java코딩에서 VO클래스르 만드는 원리와 비슷하다
-- 데이터를 취급하는 최소한의 규격, 형식을 지정하여 생성한다

-- DDL명령중에 Table 생성하기
-- Table은 데이터를 저장하기위한 표를 작성하는것으로 
-- 각 데이터의 이름을 지정하고 각 데이터의 형식을 지정하여 표를 작성한다

-- 데이터 type
-- 문자열데이터 CHAR : 저장되는 데이터의 길이가 규칙으로 정해진 경우,일정한 경우
-- 데이터의 길이가 모두 같은 경우 ("고정길이문자열")
-- VARCHAR : 저장되는 데이터의 최대 크기만 지정하고 최대크기보다 적은 데이터를
-- 저장할수 있다 최대 크기보다 짧은 데이터를 저장하면 자동으로 공간을 축소하여 저장한다
-- ("가변길이 문자열") nVarCHAR : 한글과 같은 유니코드 문자열을 저장할때 
-- 영문 알파벳과 저장하는 방식이 달라서 문제를 일으킬수있다.
-- 한글과 같은 유니코드 데이터를 저장하는 칼럼은 nVarCHAR 키워드를 사용한다

-- 숫자 데이터
-- 정수,실수 등을 구분하여 저장하기도 하지만
-- 오라클에서는 NUMBER키워드로 일괄지정하여도 상관없다
-- 저장되는 자릿수에 따라 자동으로 크기가 조절된다
-- SNAKE CASE 
CREATE TABLE tbl_score(
    sc_num CHAR(5),-- 문자열 5자리의 데이터만 저장,String num
    sc_name NVARCHAR2(20),-- String name  
    sc_kor NUMBER,
    sc_eng NUMBER,
    sc_math NUMBER 
);

-- DML(Data Manipulation Lang (Data Management Lang) 데이터 조작어)
-- 생성된 TABLE에 데이터추가,삭제,조회,수정을 하는 명령어
-- DBMS 대표적인 CRUD업무
-- 데이터 추가 (데이터생성-Create 업무) : INSERT
-- 데이터 조회 (읽기 read) : SELECT
-- 데이터 변경, 수정 : UPDATE
-- 데이터 삭제 : DELETE

INSERT INTO tbl_score(sc_num,sc_kor,sc_eng,sc_math)
VALUES ('00001',90,80,70);

INSERT INTO tbl_score(sc_name) VALUES('홍길동');
INSERT INTO tbl_score(sc_name) VALUES('성춘향');
INSERT INTO tbl_score(sc_name) VALUES('이몽룡');

-- 데이터 읽기
SELECT sc_num,sc_kor,sc_eng,sc_math
FROM tbl_score;

SELECT sc_name FROM tbl_score;
-- 모든 이름이 바뀌는 코드 사용시 주의 
UPDATE tbl_score SET sc_name='임꺽정';
SELECT sc_name FROM tbl_score;

