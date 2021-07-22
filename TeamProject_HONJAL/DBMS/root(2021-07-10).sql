CREATE DATABASE honjalDB;

USE honjalDB;

CREATE TABLE tbl_member(
	member_num	BIGINT AUTO_INCREMENT PRIMARY KEY,
	member_level BIGINT	NOT NULL,
	member_id VARCHAR(20)	NOT NULL UNIQUE,
	member_pw VARCHAR(30)	NOT NULL,
	member_nname VARCHAR(30)	NOT NULL UNIQUE,
	member_email VARCHAR(30)	NOT NULL UNIQUE
);
DROP TABLE tbl_member;
SELECT * FROM tbl_member;


CREATE TABLE tbl_content(
	content_num	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	member_num	BIGINT	NOT NULL,
    member_nname VARCHAR(30) NOT NULL,
	board_code	CHAR(5)	NOT NULL,
	content_date	VARCHAR(10)	NOT NULL,
	content_time	VARCHAR(10)	NOT NULL,
	content_view	INT NOT NULL,
	content_good	INT	NOT NULL,
	content_title	VARCHAR(125) NOT NULL,
	content_text	VARCHAR(2000) NOT NULL	
);
DROP TABLE tbl_content;
SELECT * FROM tbl_content;

INSERT INTO tbl_content(member_num, member_nname, board_code, content_date, content_time, content_view, content_good, content_title, content_text)
VALUES (1, "csy", "TIP-1", "2021-07-10", "15:13:00", 0, 0, "test", "테스트");


CREATE TABLE tbl_board(
	board_code	CHAR(5)		PRIMARY KEY,
	board_name	VARCHAR(20)	NOT NULL	
);
DROP TABLE tbl_board;
SELECT * FROM tbl_board;


CREATE TABLE tbl_comment(
	comment_num	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	content_num	BIGINT	NOT NULL,
	member_num	BIGINT	NOT NULL,
	board_code	CHAR(4)	NOT NULL,
	comment_writer	VARCHAR(10)	NOT NULL,
	comment_text	VARCHAR(500)	NOT NULL,	
	comment_time	VARCHAR(20)	NOT NULL	
);
DROP TABLE tbl_comment;
SELECT * FROM tbl_comment;


CREATE TABLE tbl_file(
	file_num	BIGINT PRIMARY KEY,
	content_num	BIGINT NOT NULL,
	member_num	BIGINT NOT NULL,
	board_code	 CHAR(4) NOT NULL,	
	file_name	VARCHAR(200) NOT NULL	
);
DROP TABLE tbl_file;
SELECT * FROM tbl_file;


CREATE TABLE tbl_scrap(
	scrap_num	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	content_num	BIGINT	NOT NULL,
	member_num	BIGINT	NOT NULL,
	board_code	 CHAR(4)	NOT NULL,
	scrap_date	VARCHAR(20)	NOT NULL	
);
DROP TABLE tbl_scrap;
SELECT * FROM tbl_scrap;





-- 게시물 테이블

ALTER TABLE tbl_content 
ADD CONSTRAINT fk_content_member_num 
FOREIGN KEY (member_num) 
REFERENCES tbl_member(member_num); 

ALTER TABLE tbl_content
ADD CONSTRAINT fk_content_board_code
FOREIGN KEY (board_code) 
REFERENCES tbl_board(board_code);



-- 댓글 테이블

ALTER TABLE tbl_comment
ADD CONSTRAINT fk_comment_content_num
FOREIGN KEY (content_num) 
REFERENCES tbl_content(content_num);

ALTER TABLE tbl_comment
ADD CONSTRAINT fk_comment_member_num
FOREIGN KEY (member_num) 
REFERENCES tbl_member(member_num);

ALTER TABLE tbl_comment
ADD CONSTRAINT fk_comment_board_code
FOREIGN KEY (board_code) 
REFERENCES tbl_board(board_code);



-- 첨부파일 테이블
ALTER TABLE tbl_file
ADD CONSTRAINT fk_file_content_num
FOREIGN KEY (content_num) 
REFERENCES tbl_content(content_num);

ALTER TABLE tbl_file
ADD CONSTRAINT fk_file_member_num
FOREIGN KEY (member_num) 
REFERENCES tbl_member(member_num); 

ALTER TABLE tbl_file
ADD CONSTRAINT fk_file_board_code
FOREIGN KEY (board_code) 
REFERENCES tbl_board(board_code); 



-- 스크랩 테이블

ALTER TABLE tbl_scrap
ADD CONSTRAINT fk_scrap_content_num
FOREIGN KEY (content_num)
REFERENCES tbl_content(content_num); 

ALTER TABLE tbl_scrap
ADD CONSTRAINT fk_scrap_member_num
FOREIGN KEY (member_num)
REFERENCES tbl_member(member_num); 

ALTER TABLE tbl_scrap
ADD CONSTRAINT fk_scrap_board_code
FOREIGN KEY (board_code)
REFERENCES tbl_board(board_code); 





INSERT INTO tbl_member(member_level, member_id, member_pw, member_nname, member_email)
VALUES (0, 'sy', 'sy1', 'csy', 'sy@naver.com');

INSERT INTO tbl_board(board_code, board_name)
VALUES ("NOT-1","공지사항");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("INF-1","정보게시판");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("TIP-1","생활TIP-청소세탁");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("TIP-2","생활TIP-요리");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("TIP-3","생활TIP-공간활용");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("TIP-4","생활TIP-기타");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("INT-1","랜선집들이");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("TAL-1","혼잘TALK-정보TALK");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("TAL-2","혼잘TALK-자유TALK");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("REV-1","리뷰게시판-생활용품");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("REV-2","리뷰게시판-음식점");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("REV-3","리뷰게시판-기타");
INSERT INTO tbl_board(board_code, board_name)
VALUES ("QNA-1","자취QNA");


SELECT * FROM tbl_content
		WHERE content_num = 4;

-- 전체글 목록
SELECT * FROM tbl_content
ORDER BY content_ntbl_memberum DESC;

SELECT * FROM tbl_content
WHERE board_code = "TIP-1"
ORDER BY content_date DESC, content_time DESC;
        
DELETE FROM tbl_content WHERE content_num = 1;

UPDATE tbl_content
SET content_title = "업데이트 테스트", content_text = "업데이트 테스트 내용"
WHERE content_num = 1;

DESC TBL_CONTENT;

SELECT
content_num,
member_num,
member_nname,
CO.board_code,
BO.BOARD_NAME,
content_date,
content_time,
content_view,
content_good,
content_title,
content_text
FROM TBL_CONTENT CO
	LEFT JOIN TBL_BOARD BO
		ON CO.BOARD_CODE = BO.BOARD_CODE;
	

SELECT * FROM tbl_content
WHERE content_title LIKE CONCAT('%', "자유", '%') AND board_code LIKE CONCAT("TAL", '%')

ORDER BY content_num DESC;

-- 인기글
SELECT * FROM tbl_content
WHERE board_code LIKE CONCAT("TIP",'%')
ORDER BY content_good DESC LIMIT 5;

SELECT * FROM tbl_member;