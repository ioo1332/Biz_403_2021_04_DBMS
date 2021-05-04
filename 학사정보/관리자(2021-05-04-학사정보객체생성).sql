--관리자영역 학사정보 프로젝트 객체 생성
CREATE TABLESPACE KschoolDB
DATAFILE 'C:/oraclexe/data/Kschool.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER kscuser IDENTIFIED BY kscuser
DEFAULT TABLESPACE KschoolDB;

GRANT DBA TO kscuser;

