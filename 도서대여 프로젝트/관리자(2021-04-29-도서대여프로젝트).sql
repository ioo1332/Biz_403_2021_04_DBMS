--여기는 관리자 접속
--프로젝트에서 사용할 TABLESPACE USER 생성

CREATE TABLESPACE RentBookDB
DATAFILE 'C:/oraclexe/data/rentbook.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER bookuser IDENTIFIED BY bookuser
DEFAULT TABLESPACE RentBookDB;

DROP USER bookuser CASCADE;

GRANT DBA TO bookuser;

REVOKE CREATE SESSION FROM bookuser;


