--관리자 권한접속
CREATE TABLESPACE schoolDB
DATAFILE 'C:/oraclexe/data/school.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

DROP TABLESPACE schoolDB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

-- SCHEMA 스키마 : table,index,view등등 데이터의 전체적인 모음집
-- 객체들의 정보를 담는곳
-- 데이터들의 모음체
-- 표준 SQL : create schema
CREATE USER scUser IDENTIFIED BY scUser
DEFAULT TABLESPACE schoolDB;

DROP USER scUser CASCADE;
-- 실습을위해 DBA로 권한부여
-- DBA권한을 남발하면 DB 보안적 측면에서 무결성을 해칠수있는 여지가많아진다
-- DB와 관련된 보안용어
-- 보안침해: 허가받지 않는 사용자가 접속하여 문제를 일으키는 경우.
-- 무결성 침해(파괴):허가받은 사용자가 권한을 남용하여 문제를 일으키는경우나
-- CUD(추가,수정,삭제)등을 잘못하여 데이터에 문제 생기는 경우.
GRANT DBA TO scUser;




