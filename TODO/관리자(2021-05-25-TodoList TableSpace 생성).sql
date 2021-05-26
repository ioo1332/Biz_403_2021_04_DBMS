--관리자 
CREATE TABLESPACE TodoListDB
DATAFILE 'C:/oraclexe/data/todolist.dbf'
SIZE 1M AUTOEXTEND on next 1k;

create USER todouser IDENTIFIED BY todouser
DEFAULT TABLESPACE TodoListDB;

GRANT DBA to todouser;

