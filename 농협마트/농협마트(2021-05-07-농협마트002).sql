--nhuser접속

/*
iolist테이블과 prod테이블간에 상품으로 join을 하여 null값이 없는것이 확인되었다
1.iolist테이블에 상품코드 갈럼을 추가하고
2.prod테이블에서 상품코드를 가져와 iolist테이블에 저장
3.illist테이블과 prod테이블간에 상품코드를 기준으로 join을 할수있도록
테이블 변경을 시작한다
*/

--tbl_iolist에 상품코드를 저장할 칼럼을 추가
ALTER TABLE tbl_iolist
ADD io_pcode CHAR(6);

DESC tbl_iolist;

--생성된 io_pcode칼럼에 io_pname칼럼의 상품이름에 해당하는 
--코드데이터를 tbl_product에서 가져와서 저장을 해야한다

--테이블의 데이터를 변경하기 위한 DML
--tbl_iolist 전체를 반복하면서 
--io_pcode칼럼에 값을 갱신하라
--이때 tbl_iolist의 상품으로 tbl_product 데이터를 조회하여
--일치하는 데이터가 있으면 그중에 상품코드 칼럼의 값을 가져와서 
--io_pcdoe에 저장하라
UPDATE tbl_iolist IO
SET io_pcode=(
    SELECT p_code FROM tbl_product P
    WHERE IO.io_pname=P.p_name
);
UPDATE tbl_iolist IO
SET io_pcode='A';
/*
iolist전체 데이터를 보여달라
iolist데이터의 상품 이름을 product테이블에서 조회하여 
일치하는 상품이 있으면 리스트를 보일때 같이 보여달라
라는 sub query
*/

SELECT IO.io_pname,
(SELECT P.p_name FROM tbl_product P
WHERE IO.io_pname=P.p_name
)AS 상품이름,
(SELECT P.p_code FROM tbl_product P
WHERE IO.io_pname=P.p_name
)AS 상품코드
FROM tbl_iolist IO;

--tbl_iolist의 상품코드 칼럼에 저장된 값과
--tbl_product의 상품코드를 join하여 데이터 조회
SELECT io.io_pcode,io.io_pname,
        p.p_code,p.p_name,p.p_iprice,p.p_oprice
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pcode=P.p_code;

/*
매입매출 데이터에서 거래처 정보를 추출하고 거래처 정보 데이터를 생성한후
거래처 코드를 만들고 tbl_dept table을 작성한다음 데이터 import

iolist에 io_dcode 칼럼을 추가하고 데이터를 update수행
*/

--1. iolist로부터 거래처명 대표자명 칼럼을 기준으로 중복되지않은 데이터를 조회
-- 거래처명 , 대표자명 순으로 정렬
-- PROJECTION : 기준이되는 칼럼을 SELECT표현
-- 필요한 칼럼만나타나며 전체 데이터가 출력
--중복되지않게 (같은데이터는1번만출력)
--칼럼을 GRUOP BY묶기

SELECT io_dname,io_dceo
FROM tbl_iolist 
GROUP BY io_dname,io_dceo
ORDER BY io_dname,io_dceo;

CREATE TABLE tbl_dept(
    d_code	CHAR(5)		PRIMARY KEY,
    d_name	NVARCHAR2(50)	NOT NULL,	
    d_ceo	NVARCHAR2(20)	NOT NULL,	
    d_tel	VARCHAR2(20)		,
    d_addr	NVARCHAR2(125)		,
    d_product	NVARCHAR2(20)		
);

-- import된 거래처정보와 매입 매출정보를 join하여 null값이 있는지 확인

        
SELECT io_dname, d_name, d_ceo, d_code
FROM tbl_iolist
    LEFT JOIN tbl_dept 
        ON io_dname = d_name AND io_dceo = d_ceo;


--tbl_iolist에 io_dcode칼럼 추가 CHAR(5)

ALTER TABLE tbl_iolist
ADD io_dcode CHAR(5);
--거래처정보 테이블에서 거래처 코드를 조회하여 tbl_ioist의 io_decode 칼럼에 update
UPDATE tbl_iolist
SET io_dcode = (
    SELECT d_code
    FROM tbl_dept
        WHERE io_dname = d_name AND io_dceo = d_ceo
);

SELECT io_date, io_time,
    io_pcode, p_name,
    io_dcode, d_name, d_ceo,
    DECODE(io_inout,'1','매입','2','매출') AS 구분,
    io_qty, io_price
FROM tbl_iolist
    LEFT JOIN tbl_product
        ON p_code = io_pcode
    LEFT JOIN tbl_dept
        ON d_code = io_dcode;



