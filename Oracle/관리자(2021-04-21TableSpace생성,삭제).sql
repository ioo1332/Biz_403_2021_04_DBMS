-- 04-21 객체생성,삭제
-- TABLESPACE 생성
CREATE TABLESPACE iolistDB
DATAFILE 'C:/oraclexe/data/iolist.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

-- TABLESPACE 삭제
-- 반드시 옵션을 같이 작성
DROP TABLESPACE iolistDB --필수
INCLUDING CONTENTS AND DATAFILES --옵션
CASCADE CONSTRAINTS; --옵션

-- 사용자 생성
CREATE USER iouser IDENTIFIED BY iouser
DEFAULT TABLESPACE iolistDB;
-- 사용자 삭제 - 삭제시 연결 해제 확인
DROP USER iouser CASCADE;
-- 사용자 DBA 권한 부여
GRANT DBA TO iouser;


