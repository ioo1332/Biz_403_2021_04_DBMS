use bookrent;

create table tbl_member(
	m_username	varchar(10)		PRIMARY KEY,
	m_password	varchar(10)	NOT NULL	,
	m_name	varchar(10)	NOT NULL	,
	m_nname	varchar(10)	NOT NULL	,
	m_email	varchar(10)	NOT NULL	,
	m_tel	varchar(10)		,
	m_addr	varchar(125)		
);

use mybook;
desc tbl_books;
create database db_school;
use db_school;
drop table tbl_student;
create table tbl_student(	
st_num	char(8)		Primary key,
st_name	varchar(20)	NOT NULL	,
st_dept	varchar(20)	NOT NULL	,
st_grade	int	NOT NULL	,
st_tel	varchar(15)	NOT NULL,	
st_addr	varchar(125)		
);
drop table tbl_student;
 
insert into
tbl_student(st_num,
st_name,
st_dept,
st_grade,
st_tel)
values('20210102',
'홍길동',
'컴공과',
'2',
'010-0000-0000');
use db_school;
drop table tbl_score;
/* table에
	insert into on duplicate key update를 실행하기 위해서는 pk 설정을 변경해야한다
tbl_score 는 두개의 칼럼을 기준으로 delete, update를 수행하는 문제가 발생한다
가장 좋은 설계는 update delete를 수행할때 한개의 칼럼으로 구성된 pk를 기준으로 수행하는 것이다
*/
create table tbl_score(
sc_seq	bigint	auto_increment	primary key,
sc_stnum	char(8)	NOT NULL	,
sc_sbcode	char(4)	NOT NULL,	
sc_score	int	NOT NULL	,
primary key(sc_stnum,sc_sbcode)
);
/* pk는 그대로 살려두고 두개의 칼럼을 묶어 unique로 설정
	두개 칼럼의 값이 동시에 같은 경우는 추가하지 말라는 제약조건 설정
*/
create table tbl_score(
sc_seq	bigint	auto_increment	primary key,
sc_stnum	char(8)	NOT NULL	,
sc_sbcode	char(4)	NOT NULL,	
sc_score	int	NOT NULL	,
unique(sc_stnum,sc_sbcode)
);

drop table tbl_score;
INSERT INTO tbl_score(sc_stnum,sc_sbcode,sc_score)
values('2021001','s001',90);
INSERT INTO tbl_score(sc_stnum,sc_sbcode,sc_score)
values('2021001','s002',90);
INSERT INTO tbl_score(sc_stnum,sc_sbcode,sc_score)
values('2021001','s003',90);

create table tbl_subject(
sb_code	char(4)		primary key,
sb_name	varchar(20)	NOT NULL	,
sb_prof	varchar(20)		
);
drop table tbl_subject;
INSERT INTO tbl_subject(sb_code,sb_name)
values('s001','국어');
INSERT INTO tbl_subject(sb_code,sb_name)
values('s002','영어');
INSERT INTO tbl_subject(sb_code,sb_name)
values('s003','수학');
INSERT INTO tbl_subject(sb_code,sb_name)
values('s004','음악');
INSERT INTO tbl_subject(sb_code,sb_name)
values('s005','과학');

insert into tbl_score(sc_stnum,sc_sbcod,sc_score)
value('20210001','s001',88);

/* tbl_suject tbl_score table을 가지고
각 학생의 성적리스트 출력해보기
과목 리스트를 출력하고 각 과목의 성적이 입력된 학생의 리스트를 확인하기

학번을 조건으로하여 한 학생의 성적입력 여부확인
학생의 점수가 입력된 과목과 입력되지않은 과목을 확인하고싶다

*/
-- subquery
select SB.sb_code,SB.sb_name,SB.sb_prof,SC.sc_stnum,SC.sc_score
from tbl_subject SB
	left join (select*from tbl_score where sc_stnum='2021001')SC
		on SC.sc_sbcode=SB.sb_code
where SC.sc_stnum='2021001';
/* 과목 리스트를 전체 보여주고 학생의 성적 table을 join하여 학생의 점수가 있으면 점수를 보이고
	없으면 null로 보여주는 sql문
    
    이 join명령문에 특정한 학번을 조건으로 보여주고
    
    
*/

select SB.sb_code,SB.sb_name,SB.sb_prof,SC.sc_stnum,SC.sc_score
from tbl_subject SB
	left join tbl_score SC
		on SC.sc_sbcode=SB.sb_code	
		and SC.sc_stnum='2021001' limit 5;
        
delete from tbl_subject
where sb_code="과목코드";
use db_school;
select count(*)from tbl_score
where sc_stnum='2021007'
