--관리자영역 테이블스페이스 생성
CREATE TABLESPACE nonghyupDB
DATAFILE 'C:/oraclexe/data/nonghyup.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER nhuser IDENTIFIED BY nhuser
DEFAULT TABLESPACE nonghyupDB;

GRANT DBA TO nhuser;