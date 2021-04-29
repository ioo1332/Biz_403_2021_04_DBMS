--여기는 bookuser

CREATE TABLE tbl_books(
bk_isbn	CHAR(20)		PRIMARY KEY,
bk_title	nVARCHAR2(50)	NOT NULL	,
bk_ccode	CHAR(5)	NOT NULL	,
bk_acode	CHAR(5)	NOT NULL	,
bk_date	CHAR(10)		,
bk_price	NUMBER		,
bk_pages	NUMBER		
);
DROP TABLE tbl_books;

CREATE TABLE tbl_company(
cp_code	CHAR(5)		PRIMARY KEY,
cp_title	nVARCHAR2(125)	NOT NULL	,
cp_ceo	nVARCHAR2(20)		,
cp_tel	VARCHAR(20),
cp_addr	nVARCHAR2(125)		,
cp_genre	nVARCHAR2(30)		
);
DROP TABLE tbl_company;

CREATE TABLE tbl_author(
au_code	CHAR(5)		PRIMARY KEY,
au_name	nVARCHAR2(50)	NOT NULL,	
au_tel	VARCHAR(20)		,
au_addr	nVARCHAR2(125)	,	
au_genre	nVARCHAR2(30)		
);
DROP TABLE tbl_author;

SELECT
    *
FROM tbl_author,tbl_books,tbl_company;
