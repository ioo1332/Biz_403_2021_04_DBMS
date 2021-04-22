-- SCUSER로 접속
CREATE TABLE tbl_student(
    st_num CHAR(5), -- 고정길이 문자열
    st_name NVARCHAR2(20), --한글이 포함된 가변문자열
    st_dept NVARCHAR2(10),
    st_grade VARCHAR(5), --(기본 가변 문자열)숫자값 입력,숫자값을 문자형으로  
    st_tel VARCHAR(20), -- 000-0000-0000
    st_addr NVARCHAR2(125) 
);


SELECT
    *
FROM tbl_student;

