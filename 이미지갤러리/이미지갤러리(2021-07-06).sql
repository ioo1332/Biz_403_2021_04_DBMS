use mylibs;

CREATE TABLE tbl_gallery(
	g_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	g_writer	VARCHAR(20)	NOT NULL	,
	g_date	VARCHAR(10)	NOT NULL	,
	g_time	VARCHAR(10)	NOT NULL	,
	g_subject	VARCHAR(50)	NOT NULL	,
	g_content	VARCHAR(1000)	NOT NULL,	
	g_image	VARCHAR(125)		
);

SHOW TABLES;

drop table tbl_gallery;

create table tbl_files(
	file_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	file_gseq	BIGINT	NOT NULL	,
	file_original	VARCHAR(125)	NOT NULL	,
	file_upname	VARCHAR(125)	NOT NULL	
);
drop table tbl_files;

insert into tbl_gallery(
g_writer,g_date,g_time,g_subject,g_content)
values
('ioo','2021-07-06','15:18:00','연습','진짜연습');
-- 현재 연결된 SESIION에서 INSERT가 수행되고
-- 그 과정에서 AUTO_INCREMENT 칼럼이 변화가 있으면 
-- 그 값을 알려주는 함수
select last_insert_id();


-- insert를 수행할때
-- auto_increment로 설정된 칼럼에 
-- 0 또는 null,''등을 설정하면
-- auto_increment가 작동된다
insert into tbl_gallery(
g_seq,g_wirter,g_date,g_time,g_subject,g_content)
value
(0,'ioo','2021','00:00','제목','내용');

select * from tbl_files;
select * from tbl_gallery;
-- eqjoin
-- 카티션곱
-- 두개의 테이블 조인 
-- 테이블1개수 * 테이블2개수만큼 리스트 출력
select * from tbl_gallery G ,tbl_files F
	where G.g_seq=F.file_gseq
		and G.g_seq=1;
create view view_갤러리 AS(
select G.g_seq AS g_seq,
		G.g_writer AS g_writer,
        G.g_date AS g_date,
        G.g_time AS g_time,
        G.g_subject AS g_subject,
        G.g_content AS g_content,
        G.g_image AS g_gimage,
		F.file_seq AS f_seq,
        F.file_original AS f_original,
        F.file_upname AS f_upname
from tbl_gallery G ,tbl_files F
	where G.g_seq=F.file_gseq
    );
    
desc view_갤러리;

select*from view_갤러리;		

