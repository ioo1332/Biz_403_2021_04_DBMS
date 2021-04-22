-- scUser 접속
SELECT*FROM tbl_student;

-- PROJECTION
-- 데이터중에 필요한 칼럼만 나열하여 데이터를 보여줘라
SELECT st_num,st_name,st_dept
FROM tbl_student;
-- PROJECTION
-- 보여지는 칼럼의 순서도 바꿀수 있다
SELECT st_name,st_tel,st_dept
FROM tbl_student;
-- 이름이 기은성인 사람의 데이터를 조회하라 비록 한개의 데이터만 보여지지만
-- 이 데이터는 2개이상 보여진다는것을 항상 전제하자.
-- 여기에서 보여지는 데이터는 무도가 list 이다

SELECT st_name,st_dept
FROM tbl_student
WHERE st_name='기은성';
-- 학번이 s0090인 학생의 정보를 조회하라
-- 학번은 pk로 선언되어있기때문에 한개의 학번만 조회를 하면
-- 이 데이터는 무조건 한개이거나 없다
-- 여기서 출력되는 데이터는 VO이다
-- VO vo =new VO()에 담아야한다
SELECT st_num,st_name,st_dept
FROM tbl_student
WHERE st_num='S0090';

--학번이 s0090이거나 s0091인 학생리스트를 보여줘라
SELECT*FROM tbl_student
WHERE st_num='s0090'or st_num='s0091';

SELECT*FROM tbl_student
WHERE st_num='s0090' or st_num='s0091' or st_num= 's0092';

SELECT
    *
FROM tbl_student
WHERE st_num IN ('s0090','s0091','s0093','s0040','s0058');

-- DBMS에서는 CHAR, VARCHAR 타입의 문자열 데이터도
-- 범위를 지정하여 조회할수있다
-- 단 데이터의 길이가 같을때 
SELECT
    *
FROM tbl_student 
WHERE st_num>'s0090'AND st_num<'s0099';

SELECT
    *
FROM tbl_student 
WHERE st_name>='기가가' AND st_name<='기힣힣';

--이름이 기로 시작되는 모든데이터를 조회
--like 조회 연산자는 가장 느리다
SELECT *
FROM tbl_student
WHERE st_name LIKE '기%'; -- '%기'

-- Full Scan 검색
-- INDEX등의 검색 최적화 기능을 모두 사용하지 않는다
SELECT *
FROM tbl_student
WHERE st_name LIKE '%기%';

SELECT *
FROM tbl_student
WHERE st_addr LIKE '%북%';

-- 주소에 북 문자열이 포함된 모든 데이터를 보여달라
-- 조회된 데이터에서 주소 칼럼을 기준으로 오름차순 정렬하라
SELECT *
FROM tbl_student
WHERE st_addr LIKE '%북%'
ORDER BY st_addr; -- ASC( 오름차순 ) 가나다 순, ABC 순, 12345순

SELECT *
FROM tbl_student
WHERE st_addr LIKE '%북%'
ORDER BY st_addr DESC ; -- DESCENDING(내림차순), 다나가, 54321
