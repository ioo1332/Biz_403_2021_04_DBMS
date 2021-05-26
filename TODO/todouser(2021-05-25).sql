--todouser접속

CREATE TABLE tbl_todolist(
    td_seq NUMBER PRIMARY KEY,
    td_date	VARCHAR2(50)		NOT NULL,
    td_time	VARCHAR2(50)	NOT NULL	,
    td_work	nVARCHAR2(125)	NOT NULL	,
    td_place	nVARCHAR2(125)	NOT NULL	
);

DROP TABLE tbl_todolist;

CREATE SEQUENCE seq_todolist
START WITH 1
INCREMENT BY 1;

DROP SEQUENCE seq_todolist;

SELECT seq_todolist.NEXTVAL FROM DUAL;


INSERT INTO tbl_todolist(td_seq,td_date,td_time,td_work,td_place)
VALUES(seq_todolist.NEXTVAL,'2021-05-25','10:14','문제해결','강의실'); 

SELECT
    *
FROM tbl_todolist;

CREATE VIEW view_할일리스트 AS
(
    SELECT td_seq 번호,
           td_date 작성일자,
           td_time 작성시간,
           td_work 할일,
           td_place 장소
      
    FROM tbl_todolist
);
