show databases;

create database myDB;

use myDB;
create table tbl_todolist(
	td_seq bigint auto_increment primary key,
    td_sdate varchar(10) not null, -- 추가된 날짜
    td_stime varchar(10) not null, -- 추가된 시간
    td_doit varchar(300) not null,
    td_edate varchar(10) default '', -- 완료된 날짜
    td_etime varbinary(10) default '' -- 완료된 시간
);
desc tbl_todolist;

select *from tbl_todolist;
