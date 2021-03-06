-- 여기는 관리자 화면으로 접속
-- 오라클에서 DBMS 프로젝트를 수행할때
-- 제일 먼저 할일 TableSpace 만들기
-- TableSpace == DataBase 실제 데이터가 저장되는 공간,파일
-- DDL(Data Definition Lang) 명령 데이터 정의어
-- DBA(Data Adminstrator)의 권한을 갖는 사용자가 사용하는 명령어
-- CREATE로 시작은 대부분의 명령어
-- Oracle에서는 SYSDBA권한 등급이 있으며 
-- 일반적인 DBA보다 높은 권한을 갖고있다
-- SYSDBA 권한은 TableSpace를 만들고 USER를 만드는역할
-- SYS 사용자로 접속한 상태
CREATE TABLESPACE schoolDB  
DATAFILE 'C:/oraclexe/data/School.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

DROP TABLESPACE schoolDB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;


-- SYSDBA는 시스템 모든부분에 접근할수있는 권한이 있어서
-- 자칫 명령을 잘못입력하고 실행하면 ORCLE DBMS자체에 문자 생긴다
-- 때문에 SYSDBA보다 등급이 낮은 사용자를 생성하고
-- 생성된 사용자 계정으로 명령을 수행,실습한다
-- 새로운 사용자 계정을 등록할때 TableSpace와 연결하여
-- 데이터를 추가할수있도록 설정
-- scuser 계정으로 데이터를 추가하면 자동으로 schoolDB tablespace에 데이터가 모인다
CREATE USER scuser IDENTIFIED BY scuser
DEFAULT TABLESPACE schoolDB;



-- DBMS에서 사용자 계정
-- DBMS는 사용자에게 권한등급을 부여하여 
-- 데이터생성,조회,삭제,변경등을 세부적으로 지정할수있다
-- 세부적인 항목은 회사,조직마다 별도로 정책을 만들어 사용하기 때문에
-- 규칙이 정해진건 없다
-- 보통 DBMS에서 새로운 사용자 계정을 등록하면 
-- 일반적인 명령을 수행할수있도록 허용하는데
-- Oracle은 새로운 사용자 계정을 생성하면 아무것도 할수없는 상태이다
-- 관리자는 새로 생성된 계정이 명령을 수행할수있도록 권한을 부여하는 명령을 수행해주어야한다
-- Oracle은 새로 생성된 사용자 계정이 DBMS에 접속하는것조차 막는다
-- 때문에 접속 profile을 만들어도 접속 TEST에서 오류가 발생한다

-- DCL(Data Controll Lang,데이터 제어어)
-- 보안과 관련된 명령
-- scuser 사용자에게 CREATE SESSION 권한을 부여
-- CREATE SESSION : DBMS 서버에 접속(logon)을 할수있는권한
-- GRANT **TO USER : USER에게 **권한을 부여한다 
GRANT CREATE SESSION TO scuser;
-- REVOKE **FROM USER: USER에게서 **권한을 제거한다
REVOKE CREATE SESSION FROM scuser;
-- tbl_school TABLE에 데이터를 추가하는권한을 scuser에게 부여
GRANT INSERT ON tbl_school TO scuser;
-- tbl_school TABLE의 데이터를 조회할수있는 권한을 scuser에게 부여
GRANT SELECT ON tbl_school TO scuser;
-- 원칙은 사용자에게 권한을 일일이 지정하여 세부적으로 관리해야하지만
-- 학습하는 입장에서 일일이 세부적으로 지정하기는 매우 불편함이 있다
-- 사용등록하고 DBA(DB관리자)권한을 부여하여 실습에 용이하도록 사용하겠다
GRANT DBA TO scuser;
