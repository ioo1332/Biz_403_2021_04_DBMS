create database score;
use score;

create table tbl_student(
st_num	char(8)		primary key,
st_name	nvarchar(20)	NOT NULL	,
st_dept	nvarchar(20)	NOT NULL	,
st_grade	bigint	NOT NULL	,
st_tel	varchar(15)	NOT NULL	,
st_addr	nvarchar(125)		
);

create table tbl_score(
sc_seq	bigint auto_increment primary key,
sc_stnum	char(8)	NOT NULL	,
sc_subject	char(4)	NOT NULL	,
sc_score	bigint	NOT NULL	
);
drop table tbl_score;

alter table tbl_score
add constraint fk_student
foreign key (sc_stnum)
references tbl_student(st_num);

alter table tbl_score
drop constraint fk_student;

