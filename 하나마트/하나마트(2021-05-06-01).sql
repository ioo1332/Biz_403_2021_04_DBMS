--여기는 iouser접속화면

CREATE TABLE tbl_iolist(
io_seq	NUMBER		PRIMARY KEY,
io_date	VARCHAR2(10)	NOT NULL,	
io_pname	NVARCHAR2(50)	NOT NULL	,
io_dname	NVARCHAR2(50)	NOT NULL	,
io_dcoe	NVARCHAR2(20)	NOT NULL	,
io_inout	NVARCHAR2(5)	NOT NULL,	
io_qty	NUMBER	NOT NULL	,
io_price	NUMBER	NOT NULL,	
io_total	NUMBER	
);
DROP TABLE iolist;

SELECT COUNT(*)FROM tbl_iolist
WHERE io_inout='매입';

SELECT COUNT(*)FROM tbl_iolist
WHERE io_inout='매출';

SELECT io_inout,count(*)
FROM tbl_iolist
GROUP by io_inout;

SELECT io_inout,SUM (io_total)
FROM tbl_iolist
GROUP BY io_inout;

SELECT io_inout,
DECODE(io_inout,'매입',io_total)as 매입합계,
DECODE(io_inout,'매출',io_total)as 매출합계
FROM tbl_iolist;

SELECT
SUM(DECODE(io_inout,'매입',io_total))as 매입합계,
SUM(DECODE(io_inout,'매출',io_total))as 매출합계,
SUM(DECODE(io_inout,'매출',io_total))-
SUM(DECODE(io_inout,'매입',io_total))as 이익금
from tbl_iolist;

--매입매출관련하여 
--소매점에서 상품을 매입하여 소비자한테 판매할때 
--매입할때 매입 부가세 발생
--판매할때 매출 부가세 발생
--매출 부가세 -매입 부가세를 계산하여 일년에 2~4회에 부가가치세를 납부한다.

--농사를 지어서 쌀20kg생산하여 판매를 하면
--5만원정도의 금액에 판매하게 된다
--쌀을 공장에서 가공하여 생산품으로 만들게 되면 실제 20kg쌀을 직접 판매하는거보다
--더비싼 가격에 판매하게 된다 이때 실세쌀보다 더 많은 이익이 발생하게 되므로
--가치가 부가되었다라고 한다 가치가 부가된만큼 세금을 납부하도록한다
--부가가치세 (value add tax ,VAT)
--매입을 할때는 매입금액의 10퍼센트 만큼으로 세금을 포함하여 매입하고
--매출할때는 매출금액의 10퍼센트 만큼 세금을 포함하여 판매한다

--매입매출 데이터에서 보면
--매입금액은 부가세10%를 제외한 금액으로 입력하고
--매출금액은 부가세 10%가 포함된 금액으로 입력한다
--샘플데이터의 매입금액은 vat제외 금액이고
--매출금액은 VAT포함 금액이다
--매입과 매출데이터로 지난 1년간 납부한 VAT금액을 계산해보자
--매입금액:22737397
--매출금액:41683800
--vat(매출금액에 포함된 VAT)-(매입금액*0.1)
--매출금액의 vat제외된 합계 = 매출금액/1.1
--매출부가세 vat제외된 매출금액*0.1

--일년동안 매입매출 결과에 대한 납부한 부가세 계산
SELECT 
SUM(DECODE(io_inout,'매입',ROUND(io_total*0.1)))AS 매입부가세,
SUM(DECODE(io_inout,'매출',ROUND((io_total/1.1)*0.1)))AS 매출부가세,
SUM(DECODE(io_inout,'매출',ROUND((io_total/1.1)*0.1)))-
SUM(DECODE(io_inout,'매입',ROUND((io_total/1.1)*0.1)))AS 매출부가액
FROM tbl_iolist;

--거래처별로 매입과 매출합계
--DECODE(칼럼명,조건값,TRUE일때,FALSE일때)
--실제 저장된 데이터를 PIVOT으로 보여주기
SELECT io_dname,
SUM(DECODE(io_inout,'매입',io_total,0)) AS 매입합계,
SUM(DECODE(io_inout,'매출',io_total,0)) AS 매출합계
FROM tbl_iolist
GROUP BY io_dname;
--상품별로 매입과 매출합계
SELECT io_pname,
SUM(DECODE(io_inout,'매입',io_total,0)) AS 매입합계,
SUM(DECODE(io_inout,'매출',io_total,0)) AS 매출합계
FROM tbl_iolist
group by io_pname;

--2020-01-01부터 2020-06-30기간동안 거래된 리스트 거래처별로 조회
SELECT io_dname,
SUM(DECODE(io_inout,'매입',io_total,0))AS 매입,
SUM(DECODE(io_inout,'매출',io_total,0))AS 매출
FROM tbl_iolist
WHERE io_date BETWEEN '01/01/2020' AND '06/01/20020'
group by io_dname
ORDER by io_dname;

--전체 데이터에서 상품 리스트만 중복없이 조회
--상품리스트와 매입 매출가를 조회하기
--같은 상품이라도 거래 시기에 따라 매입과 매출금액이
--달라질수있기때문에
--단가 데이터중에서 제일높은 단가를 가져오기
SELECT io_pname,
MAX(DECODE(io_inout,'매입',io_total,0))AS 매입단가,
MAX(DECODE(io_inout,'매출',io_total,0))AS 매출단가
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;
/*
매입매출 데이터로 부터 상품정보 테이블 데이터를 생성하기
1. 매입매출 데이터에서 상품명으로 그룹을 하고
2. 매입, 매출 구분에 따라 각각 매입단가, 매출단가를 가져오기
3. 매입과 매출에 0인 값이 있다
4. 매입단가가 0인 데이터는 매출데이터에서 임의로 생성하기
 매출단가의 80%를 매입단가로 하고, 부가세를 제외한 금액으로 계산
 E2 항목의 값에 0.8을 곱하여 80% 가격이 되고
 다시 그 금액을 1.1로 나누면 부가세를 제외한 가격이 된다.
 =ROUND(IF(C2 = 0,((E2 * 0.8)/1.1),C2),0)
5. 매출단가가 0인 데이터는 매입데이터에서 임의로 생성하기
매입단가의 20%를 추가하고 부가세 10%를 추가 
        매입단가 + 20% + 10%
        
=IF( E2=0, INT( ( D2 * 1.2 ) * 1.1 )/10 * 10, E2 )
 10원 단위 이상으로 계산하기
*/

--전체 데이터에서 거래처 리스트만 중복없이 조회
SELECT io_dname,io_dcoe
FROM tbl_iolist
GROUP BY io_dname,io_dcoe
ORDER by io_dname;

--상품정보테이블
--default속성
--INSERT를 수행할때 값이 지정되지않으면
--자동으로 추가될 데이터
--자동으로 NOT NULL설정
CREATE TABLE tbl_product(
    p_code	CHAR(6)		PRIMARY KEY,
    p_name	NVARCHAR2(50)	NOT NULL,	
    p_iprice	NUMBER	NOT NULL	,
    p_oprice	NUMBER	NOT NULL	,
    p_vat	VARCHAR2(1)	DEFAULT 'Y'	
);

CREATE TABLE tbl_dept (
    dp_code	CHAR(5)		PRIMARY KEY,
    dp_name	nVARCHAR2(50)	NOT NULL,	
    dp_coe	nVARCHAR2(50)	NOT NULL,	
    dp_tel	VARCHAR2(20),		
    dp_addr	nVARCHAR2(125)		
);
drop table tbl_dept;

/*
매입매출 데이터로 부터
상품정보, 거래처정보 데이터를 생성하고
테이블을 생성하여 데이터를 import 했다
매입매출데이터와, 상품정보, 거래처정보를
JOIN하기 위해서는 매입매출데이터에 상품코드, 거래처코드가 
있어야 한다.
그러나 현재 데이터는 코드 칼럼이 없이 이름 칼럼만 있는 상태이다
매입매출 데이터에 상품코드, 거래처코드 칼럼을 추가하고
세 table을 JOIN할수 있도록 변경하기
*/



