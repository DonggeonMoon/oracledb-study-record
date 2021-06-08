select * from tab;
--한줄 주석;
/*
sql 5가지 명령어 세트로 구성되어 있다.
1. DQL(Data Query Language): 데이터 조회어 
   Select문
   데이터 베이스에서 데이터를 검색해서 사용자가 원하는 데이터를 확인 및 사용할 수 있다.
2. DML(Data Manpulation Language): 데이터 조작어
   INSERT, ALTER, DROP, TRUNCATE
   데이터베이스의 테이블에 새로운 행의 삽입, 수정, 삭제
3. DDL(Data Definition Language): 데이터 정의어
   CREATE, VIEW, DROP, TRUNCATE
   데이터베이스에 태이블의 생성, 변경, 삭제 등을 하는 명령어
   테이블 뷰, 유저, 시퀀스 동의어
4. DCL(Data Control Language): 데이터 컨트롤
   GRANT(부여), REVOKE(제거)
   데이터베이스에 접속하는 사용자에게 데이터베이스와 그 안에 구조에 대한 액세스 권한을 부여 또는 제거
5. TCL(Transaction Control Language): 데이터 수행 처리단위
   COMMIT, SAVEPOINT, ROLLBACK
   어느 시점의 데이터 저장, 되돌리기 등...
 
*/

/*
1. DQL: SELECT 문의 사용목적: 데이터베이스에 저장된 데이터를 사용자 프로그램에서 사용하기
   위해서 SELECT문을 이용하여 질의할 수 있다. 즉, 프로그램에서 처리할 데이터를 사용자 
   프로그램으로 가져오기 위해 사용한다. DB에서 읽어오기만 하니까 DB 내용은 변하지 않는다.
   오라클 대소문자 구분 안 한다. 컬럼 이름은 구분한다.(예. SMITH, Smith)
   기본 문법 : SELECT 컬럼1, 컬럼2, ..., 컬럼n(와일드 문자 *는 전부 선택) FROM 테이블명,
   소유자명 - FROM절
   WHERE 조건 -WHERE절

   단순 SELECT문은 하나의 테이블 대해 질의할 때 사용, FROM절에 테이블 명만 명시한다.
   SQL문의 종료 시 ;으로 마무리.
*/

-- EMP 테이블에서 모든 정보를 조회하시오.
SELECT *
FROM EMP;

-- EMP 테이블에서 사번, 이름, 급여, 부서번호를 조회

select EMPNO, ENAME, SAL, DEPTNO
FROM EMP;

-- 테이블의 구조를 알 수 있는 명령어, 오라클에만 있음. 
DESCRIBE EMP;
DESC EMP; -- 오라클 명령엉 일 경우는 ; 생략 가능함.

--유저가 가지고 있는 모든 테이블을 검색
SELECT * 
FROM TAB;

--DEPT테이블: 부서 정보를 가지고 있는 테이블
--DEPT테이블의 구조를 파악하고 모든 정보를 표시해보자

DESC DEPT;
SELECT * 
FROM DEPT;

--컬럼에서 NUMBER, DATE 유형은 산술 연산이 가능하다.
--NUMBER(+, -, *, /) DATE(+, -) 연산 가능
--EMP테이블에서 부서번호 20번인 사원의
-- 사번, 이름, 급여, 급여에 100을 더해
--출력해보자.

SELECT empno, ename, SAL, SAL + 100, DEPTNO
FROM EMP
WHERE DEPTNO=20;

-- 부서번호 30인 사원의 사번, 이름, 급여, 입사일, 부서번호

SELECT EMPNO, ENAME, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE DEPTNO = 30;

-- 모든 사원의 사번, 이름, 급여, 연봉, 입사일, 부서번호
-- 연봉: (급여*12) + 커미션
--컬럼을 계산할 때 컬럼의 값이 NULL이면 계산 값은 무조건 NULL이 된다.

SELECT EMPNO, ENAME, SAL, (SAL * 12) + COMM, HIREDATE, DEPTNO
FROM EMP;

--계산 시 NULL값을 해결하는 방법: 단일행 함수 NVL()
--NVL(COMM, 0) COMM이 NULL이면 0으로 치환해라.
SELECT EMPNO, ENAME, SAL, (SAL * 12) + NVL(COMM, 0), HIREDATE, DEPTNO
FROM EMP;

--부서번호 20번인 사원의 사번, 이름, 연봉, 부서번호를 출력해보자.
-- 연봉: (급여*12) + 커미션

SELECT EMPNO, ENAME, (SAL * 12) + NVL(COMM, 0), DEPTNO
FROM EMP
WHERE DEPTNO=20;

--컬럼의 별칭(ALIAS), 별명을 사용해서 HEADING글 변경하기
--부서번호 30번의 사원의 사번, 이름, 연봉, 부서번호를 출력

SELECT EMPNO AS 사번, ENAME AS 사원명, (SAL * 12) + NVL(COMM, 0) AS 연봉, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO=30;

--부서번호 10번인 사원의 사번, 이름, 연봉, 입사일, 부서번호 출력
--AS 생략 가능하지만, 왠만하면 명기 요망

SELECT EMPNO AS 사번, ENAME AS 이름, (SAL * 12) + NVL(COMM, 0) AS 연봉, HIREDATE AS 입사일, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO = 10;

--컬럼명을 붙여서 사용하기 연산자 ||(여산자)
SELECT EMPNO||ENAME AS 사원정보
FROM EMP
WHERE DEPTNO=20;

--EMP테이블에서 부서번호를 출력
--중복값 제거
SELECT DISTINCT DEPTNO
FROM EMP;
/* SELECT문에서 조건 검색
WHERE절 산술연산자, BETWEEN, IN(), LIKE 연산자
논리 연산자 AND, OR, NOT
*/
--EMP테이블에서 이름이 KING이고 부서번호 10인 사원의 
--사번, 이름, 급여, 입사일, 직책, 부서번호를 출력해보자

SELECT EMPNO, ENAME, (SAL * 12) + NVL(COMM, 0), HIREDATE, JOB, DEPTNO
FROM EMP
WHERE ENAME='KING' AND DEPTNO=10;

--EMP테이블에서 입사일이 80년 12월 1일보다 늦게 입사한
--사원의 사번, 이름, 입사일 출력
--날짜는 어느 시점에서 0초부터 60*60*24*365

SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE HIREDATE>'81/12/01';

--부서번호가 20번이고 입사일이 81/05/31보다 늦은 사람의
-- 사번, 이름, 이사일, 부서번호를 출력

SELECT EMPNO AS 사번, ENAME AS 이름, HIREDATE AS 입사일, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO=20 AND HIREDATE>'81/05/31';

-- 단순 비교 연산자(=, <, >, <= >=, !=, ^=)
-- 급여가 1500보다 작거나 같은 사원의 정보를 출력
-- 사번, 이름, 급여, 부서번호 출력

SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL<=1500;

--급여가 2000보다 많은 사원의 사번, 이름, 급여, 부서번호, 출력

SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL>2000;

--EMP테이블에서 SAL가 1000보다 작거나 3000보다 큰 사원의 사번, 이름, 급여, 부서번호 출력
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL < 1000 OR SAL > 3000;

--EMP테이블에서 SAL 1500과 3000 사이의 사원의 사번, 이름, 급여, 부서번호 출력
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL >= 1500 AND SAL <= 3000;

SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL BETWEEN 1500 AND 3000;

--입사일이 81/03/03 ~ 82/01/01
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호, HIREDATE AS 입사일
FROM EMP
WHERE HIREDATE BETWEEN '81/03/03' AND '82/01/01';

--EMP테이블에서 부서번호 10이거나 20번인 사원의 사번, 이름, 급여, 입사일, 부서번호 출력
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO = 10 OR DEPTNO =20;

--IN() 연산자
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO IN(10, 20);
-- SAL가 800, 1200, 3000인 사원의 정보를 출력
-- 사번, 사원명, 급여, 부서번호
SELECT EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, DEPTNO AS 부서번호
FROM EMP
WHERE SAL IN(800, 1200, 3000);
-- LIKE 연산자: 문자 데이터형 전용, 값이 명시된 패턴과 동일한지 비교
-- 와일드 문자 %(모든 수), _(한글자 대치)
-- EMP테이블에서 이름이 'A'로 시작하는 사원을 검색
SELECT *
FROM EMP
WHERE ENAME LIKE 'A%';
-- EMP테이블에서 이름이 'K'로 시작하는 사원을 검색
SELECT *
FROM EMP
WHERE ENAME LIKE 'K%';
--이름에 두 번째 글자가 M인 사원의 정보 출력
SELECT *
FROM EMP
WHERE ENAME LIKE '_M%';

--마지막 바로전 글자가 N인 사원의 정보를 출력해보자
SELECT *
FROM EMP
WHERE ENAME LIKE '%N_';

--이름의 세 번째 글자가 'A'인 사원의 정보를 출력
SELECT *
FROM EMP
WHERE ENAME LIKE '__A%';

-- %, _ 와일드 문자를 검색해야 될 필요성이 있을 때

CREATE TABLE TEST01(J_CODE VARCHAR2(30));
INSERT INTO TEST01 VALUES('ADPRES');
INSERT INTO TEST01 VALUES('AD_PRES');
INSERT INTO TEST01 VALUES('AD_%PRES');
COMMIT;

SELECT *
FROM TEST01;

SELECT * 
FROM TEST01
WHERE J_CODE LIKE 'AD_%'; -- 와일드문자 _

--AD_ESCAPE문은 다음에 나오는 글자를 오일드문자가 아닌 일반 문자로 인식하게 한다.
SELECT * 
FROM TEST01
WHERE J_CODE LIKE 'AD\_%' ESCAPE '\';

--AD_% 와일드 문자가 아닌 일반문자로 검색 출력해보자
SELECT * 
FROM TEST01
WHERE J_CODE LIKE 'AD%\_\%%' ESCAPE '\';

DROP TABLE TEST01;

SELECT * FROM TAB;

PURGE RECYCLEBIN;
SELECT * FROM TAB;

-- NULL인 컬럼값 조회, IS NULL, IS NOT NULL
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NULL;

SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NOT NULL;

-- AND, OR, NOT
-- MANAGER IS NULL이고 SAL 3000보다 큰 모든 직원을 출력

SELECT *
FROM EMP
WHERE MGR IS NULL AND SAL > 3000;

--MGR IS NOT NULL이거나 SAL 4500보다 작은 직원
SELECT *
FROM EMP
WHERE MGR IS NOT NULL OR SAL < 4500;

--NOT 연산: 조건이 거짓이어야 연산외 됨.
--WHERE 절에서 연산자에 대한 NOT 연산자의 사용 예
--WHERE JOB NOT IN('CLERK', 'PRESIDENT');
--WHERE SAL NOT BETWEEN 800 AND 1500;
--WHEER ENAME NOT LIKE '%A%';
--WHERE COMM IS NOT NULL;
/*
ORDER BY절: 결과 레코드를 정렬해서 표시하고자 할 때 사용
SELECT 컬럼1,..., 컬럼n
FROM 테이블명
[WHERE 조건]: 생략 가능
[ORDER BY]: 생략 가능
ORDER BY 컬럼명, ALIAS;
OPTION: ASC: 오름차순 작은 거->큰 거, DESC: 내림차순 큰 거 -> 작은 순
DEFAULT: ASC, 그래서 생략 가능.
*/
-- EMP 테이블에서 부서번호로 정렬해보자.
SELECT *
FROM EMP
ORDER BY DEPTNO ASC;

--EMP 테이블에서 부서번호 30번인 사원을 급여 순으로 정렬해보자.
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO=30
ORDER BY SAL;

SELECT EMPNO AS 사원번호, ENAME AS 사원명, (SAL*12) + NVL(COMM, 0) AS 연봉, DEPTNO AS 부서번호
FROM EMP
WHERE DEPTNO=30
ORDER BY 연봉; --ALIAS로 ORDER BY된다.

SELECT EMPNO, DEPTNO
FROM EMP
ORDER BY 2; -- 2번째 컬럼으로 정렬해라

--NULL값이 있는 컬럼의 정렬
SELECT EMPNO, ENAME, COMM, DEPTNO
FROM EMP
WHERE DEPTNO=30
ORDER BY 3 ASC NULLS FIRST; --NULL값을 먼저 출력

SELECT EMPNO, ENAME, COMM, DEPTNO
FROM EMP
WHERE DEPTNO=30
ORDER BY 3 ASC NULLS LAST; --NULL값을 마지막에 출력

--1일차 문제
--1.
SELECT ENAME, SAL, HIREDATE
FROM EMP
DESC EMP;

--2.
SELECT ENAME, SAL, HIREDATE
FROM EMP
WHERE DEPTNO = 20;

--3.
SELECT ENAME, (SAL * 12) +NVL(COMM, 0) AS 연봉, HIREDATE
FROM EMP;

--4.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL BETWEEN 1000 AND 4000;

--5.
SELECT ENAME, SAL, HIREDATE
FROM EMP
WHERE ENAME LIKE 'S%';

--6.
SELECT ENAME AS 이름, (SAL * 12) +NVL(COMM, 0) AS 연봉, EMPNO AS 사번, SAL AS 급여, HIREDATE AS 입사일, 
FROM EMP
WHERE COMM IS NULL;

--7.
SELECT ENAME AS 이름, SAL AS 급여, (SAL * 12) + NVL(COMM, 0) AS 연봉
FROM EMP
WHERE DEPTNO = 30
ORDER BY 연봉 DESC;

--8.
SELECT *
FROM DEPT
ORDER BY DEPTNO;

select *
from TAB;

DESC EMP

--DEPT 테이블의 구조를 파악?
desc dept;
select *
from dept;

--SALGRADE 테이블의 구조를 파악하고 모든 정보를 출력
DESC SALGRADE;
SELECT
    *
FROM SALGRADE;


--EMP 구조를 알아야 컬럼값을 선택해서 출력할 수 있다.
--EMP테이블 사번, 이름, 급여, 부서번호를 선택해서 출력

DESC EMP;
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP;

--SELECT 절에서 단수 연산을 지원한다.
SELECT
EMPNO, ENAME, (SAL * 12), DEPTNO
FROM EMP;

-- ALIAS(별칭, 별명), 헤딩을 바꿀 수 있다.
SELECT
EMPNO, ENAME, (SAL * 12) AS 연봉, DEPTNO
FROM EMP;

SELECT
EMPNO, ENAME, (SAL * 12) + NVL(COMM, 0) AS 연봉, DEPTNO
FROM EMP;

--EMP테이블에서 부서번호 20인 사원 정보를 검색...
SELECT
*
FROM EMP
WHERE DEPTNO = 20;

--EMP

SELECT
EMPNO, ENAME, SAL, (SAL*12) + NVL(COMM, 0) AS 연봉, DEPTNO
FROM EMP
WHERE DEPTNO = 30;

--컬럼을 붙여서 출력하기 ||(연산자);
--EMMP테이블에서 부서번호 20번은 사원의 사번, 이읆을 붙여서 별칭을 사원정보로 하시오.
SELECT EMPNO || ENAME AS 사원정보
FROM EMP
WHERE DEPTNO = 20;

-- 중복제거 DISTINCT 연산자
-- 중복 허용 ALL 연산자 DEFAULT 생략 가능.
SELECT DISTINCT DEPTNO
FROM EMP;

/* SELECT문에서 조검 검색
    WHERE절: 산술연산자, BETWEEN, IN(), LIKE 연산자, 논리연산자(AND, OR, NOT)...
*/

--EMP에서 이름이 KING이고 부서번호 10번인 사원의 사번, 이름, 급여, 입사일, 부서번호를 출력해보자
SELECT
EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, HIREDATE AS 입사일, DEPTNO 부서번호
FROM EMP
WHERE ENAME = 'KING' AND DEPTNO = 10;

--날짜연산이 가능하다. EMP에서 81년 12월 1일보다 늦게 입사한 사원의 사번, 이름, 입사일, 부서번호 출력
SELECT EMPNO AS 사번, ENAME AS 이름, HIREDATE AS 입사일, DEPTNO 부서번호
FROM EMP
WHERE HIREDATE > '81/12/01';

-- 부서번호가 20이고, 입사일이 '81/05/31'보다 늦은 사람의 사번, 이름, 입사일, 부서번호를 출력해보자.
SELECT EMPNO AS 사번, ENAME AS 이름, HIREDATE AS 입사일, DEPTNO 부서번호
FROM EMP
WHERE DEPTNO = 20 AND HIREDATE > '81/05/31';

-- 단순 비교 연산자(=, <, >, <=, >=, !=, ^=)
-- 급여가 1500보다 작거나 같은 사원의 정보를 출력 
-- 사번, 이름, 급여, 부서버호
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL <=1500;

-- 급여가 1000보다 크고 3000보다 작은 사원의 정보를 출력.
SELECT  EMPNO AS 사번, ENAME AS 이름, DEPTNO 부서번호, SAL
FROM EMP
WHERE SAL>1000 AND SAL<3000;
-- 급여가 1500에서 3000 사이의 작은 사원의 정보를 출력.

SELECT  EMPNO AS 사번, ENAME AS 이름, DEPTNO 부서번호, SAL
FROM EMP
WHERE SAL>=1500 AND SAL<3000;

-- BETWEEN A AND B, 가독성을 높인다.
SELECT  EMPNO AS 사번, ENAME AS 이름, DEPTNO 부서번호, SAL
FROM EMP
WHERE SAL BETWEEN 1500 AND 3000;

SELECT  EMPNO AS 사번, ENAME AS 이름, SAL, DEPTNO 부서번호
FROM EMP
WHERE DEPTNO = 10 OR DEPTNO = 20;

-- IN() 연산자, 가독성을 높인다.
SELECT  EMPNO AS 사번, ENAME AS 이름, SAL, DEPTNO 부서번호
FROM EMP
WHERE DEPTNO IN(10, 20);

--문자열 비교 연산자 LIKE 연산자
--와일드 문자 %(모든 수), _(한 글자 대치)
--EMP테이블에서 이름이 'A'로 시작하는 사원을 검색
SELECT
    *
FROM EMP
WHERE ENAME LIKE 'A%';

SELECT
    *
FROM EMP
WHERE ENAME LIKE '%H';

SELECT
    *
FROM EMP
WHERE ENAME LIKE '_I%';

이름에 마지막 전 문자가 N인 사원을 출력
SELECT
    *
FROM EMP
WHERE ENAME LIKE '%N_';

SELECT
    *
FROM EMP
WHERE ENAME LIKE '__A%';

-- /%, _와일드 문자를 검색해야 될 필요성이 있을 때

CREATE TABLE TEST01(J_CODE VARCHAR2(30));
INSERT INTO TEST01 VALUES('ADPRES');
INSERT INTO TEST01 VALUES('AD_PRES');
INSERT INTO TEST01 VALUES('AD_%PRES');
COMMIT;

SELECT
    *
FROM TEST01;

SELECT
    *
FROM TEST01;
WHERE J_CODE LIKE 'A_%' ESCAPE \;

--ESCAPE ㄷ음에 나온느 글자는 와일드 문자가 아니고 일반 문자
-- 일반문자로 인식해라

SELECT
    *
FROM TEST01
WHERE J_CODE LIKE 'AD\_%' ESCAPE '\';

SELECT
    *
FROM TEST01
WHERE J_CODE LIKE 'AD\_\%%' ESCAPE '\'; --AD_

DROP TABLE TEST01 PURGE;// 테이블을 삭제와 동시에 휴지통도 비움.

SELECT
    *
FROM EMP
WHERE COMM IS NOT NULL;

-- AND, OR, NOT;
-- MGR IS NULL이고 SAL이 3000보다 큰 직원 출력
SELECT
    *
FROM EMP
WHERE MGR IS NULL AND SAL > 3000;

SELECT
    *
FROM EMP;
-- WHERE JOB NOT IN ('CLERK', 'PRESIDENT');
-- WHERE SAL NOT BETWEEN 800 AND 1500;
-- WHERE ENAME NOT LIKE '%A%';
-- WHERE COMM IS NOT NULL;
/* 정렬 ORDER BY절
SELECT 컬럼
FROM 테이블
[WHERE 조건 ] []: 생략 가능
[ORDER BY 컬럼];
맨 마지막에 기술한다.
옵션: ASC(오름차순), DESC(내림차순) DEFAULT: ASC
*/

-- EMP테이블에서 부서번호로 정렬해보자..

SELECT *
FROM EMP
ORDER BY DEPTNO ASC;

SELECT *
FROM EMP
WHERE DEPTNO = 30
ORDER BY SAL  DESC;

--EMP에서 부서번호 30번인 사원을 연봉순으로 정렬해보자

Select EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, (SAL*12+NVL(COMM, 0)) AS 연봉, DEPTNO AS 부서번호
from EMP
where DEPTNO = 30
ORDER BY 연봉 DESC;

-숫자로 정렬, 3 SELECT 두 번째 컬럼으로 정렬해라.
Select EMPNO AS 사번, ENAME AS 이름, SAL AS 급여, (SAL*12+NVL(COMM, 0)) AS 연봉, DEPTNO AS 부서번호
from EMP
where DEPTNO = 30
ORDER BY 4 DESC;

-- NULL 값이 있는 컬럼의 정렬
Select EMPNO AS 사번, ENAME AS 이름, COMM, SAL AS 급여, (SAL*12+NVL(COMM, 0)) AS 연봉, DEPTNO AS 부서번호
from EMP
where DEPTNO = 30
ORDER BY 3 DESC NULLS FIRST; -- NULL 먼저 출력 후 정렬

Select EMPNO AS 사번, ENAME AS 이름, COMM, SAL AS 급여, (SAL*12+NVL(COMM, 0)) AS 연봉, DEPTNO AS 부서번호
from EMP
where DEPTNO = 30
ORDER BY 3 DESC NULLS FIRST; -- 정렬 후 NULL 값 출력

--단일 행 함수: 오라클과 다른 DB하고 이름, 용법 차이가 있을 수 있다.
1. 문자 함수: 처리되는 데이터가 문자 유형 데이터
2. 숫자 함수: 처리되는 데이터가 숫자 유형 데이터
3. 날짜 함수: 처리되는 데이터가 날짜 유형 데이터
4. 일반 함수: 처리되는 데이터가 일반 유형 데이터
5. 형변환 함수: 처리되는 데이터가 유형 데이터
            데이터 유형으로 변경할 필요가 있을 때 사용.
            * 숫자, 날짜 데이터를 문자 데이터로 변환
            * 문자 데이터를 날짜, 숫자 데이터로 변환
-- DUAL 테이블: 오라클 서버에 접속하는 모든 계정이 함수의 테스트 등을 사용할 수 있도록 제공되는 가상 테이블

DESC DUAL;

SELECT UPPER('abcd efg hijk') AS "UPPER",
        LOWER('abcd efg hijk') AS "lower",
        INITCAP('abcd efg hijk') AS "InitCap"
FROM DUAL;
--문자 단일행 함수 UPPER('문자열') 함수, LOWER('문자열') 함수
--대문자, 소문자, 첫글자만 대문자 나머지는 소문자

--EMP부서번호 20번인 사원의 이름을 모두 소문자로 표시, JOB컬럼을 첫글자 대문자 나머지 소문자로 표시해보자
SELECT LOWER(ENAME), INITCAP(JOB), UPPER(ENAME)
FROM EMP
WHERE DEPTNO = 20;

--SELECT ENAME
--FROM EMP
--WHERE UPPER(ENAME) = 'KIM';
--CONCAT('문자열', '문자열' 함수: 두 문자열을 붙인다.
SELECT CONCAT('HELLO', 'WORLD')
FROM DUAL;

-- SUBSTR('문자열', 시작위치,[추출할 문자 수])
-- 데이터로부터 원하는 문자열을 추출

SELECT SUBSTR('20080815', 1, 4),
        SUBSTR('20080815', 5, 4), 
        SUBSTR('20080815', 7), 
        SUBSTR('20080815', -2)
FROM DUAL;

-- LENGTH('문자열') 함수: 문자열의 길이를 글자 수로 반환
-- LENGTHB('문자열') 함수: 문자열의 길이를 바이트 수로 반환
SELECT LENGTH('홍길동'), LENGTHB('홍길동')
FROM DUAL;

-- REPLACE('문자열', '찾을 문자', '대체 문자') 함수
-- 문자열에서 문자(열)을 찾아서 문자(열)로 교체
SELECT REPLACE('JACK AND JUE', 'J', 'BL'),
            REPLACE('JAVA AND ORACLE', ' AND ', '')
FROM DUAL;

-- TRIM('문자'FROM'문자열') 함수: 문자열 양끝에 연속된 문자를 삭제, 중간에 있는 문자는 삭제 불가
SELECT TRIM(BOTH 'S' FROM 'SSMISTHSS') AS "R1",
        TRIM('S' FROM 'SSMISTHSS') AS "R2",
        TRIM(LEADING 'S' FROM 'SSMISTHSS') AS "R3",
        TRIM(TRAILING BOTH 'S' FROM 'SSMISTHSS') AS "R4",

SELECT LTRIM('S', 'SSMISTHSS') AS "R1",
        RTRIM('S', 'SSMISTHSS') AS "R2",
        LTRIM(RTRIM('SSMISTHSS', 'S'), 'S') AS "R3",
FROM DUAL;

LPAD('문자열' 출력 시 사용되는 BYTE 길이, '남은 빈칸을 채울 문자')
RPAD('문자열' 출력 시 사용되는 BYTE 길이, '남은 빈칸을 채울 문자')
SELECT LPAD('SMITH', 10, '*') AS "RESULT"
FROM DUAL;

--INSTR('문자열'), 찾을 문자(열)' [, 검색 시작 자리수, 존재 )
-- 찾을 문자나 문자열이 있으면 그 문자나 문자열이 시작된 자리 수를 반환하고, 없으면 0 반환

SELECT INSTR('HELLO ORACLE', 'L', 1, 1) AS "R1",
        INSTR('HELLO ORACLE', 'L') AS "R2",
        INSTR('HELLO ORACLE', 'L', 4, 2) AS "R3",
        INSTR('HELLO ORACLE', 'L', 4, 3) AS "R4",
        INSTR('HELLO ORACLE', 'L', -8, 2) AS "R5",
        INSTR('HELLO ORACLE', 'ORACLE') AS "R6"
FROM DUAL;

SELECT EMPNO, CONCAT(ENAME, JOB) AS "NAMEJOB",
                LENGTH(ENAME), INSTR(ENAME,'A') AS "CONTIAINS A?"
FROM EMP
WHERE SUBSTR(JOB, 4) = 'RK';
-- 숫자 단일 행 함수
-- MOD(숫자1, 숫자2) 함수: 숫자1을 숫자2로 나누고 남은 나머지
SELECT MOD(1600, 2)
FROM DUAL;
---ROUND(숫자[, 소수점 이하 유효 자리수]) 함수
SELECT ROUND(1745.9260, 4) As "R1", 
        ROUND(1745.9260, 1) As "R2", 
        ROUND(1745.9260, 0) As "R3", 
        ROUND(1745.9260) As "R4"
FROM DUAL;

SELECT ROUND(1745.9260, -1) As "R1", --1의 자리
        ROUND(1745.9260, -2) As "R2", --10의 자리
        ROUND(1745.9260, -3) As "R3", --100의 자리
        ROUND(1745.9260, -4) As "R4" --1000의 자리
FROM DUAL;

-- TRUNC(숫자[, 소수점 이하 유효자리수]): 소수점이하 유효자리수 버림

SELECT TRUNC(1745.9260, 4) AS "R1", --소수점 4자리 무조건 절삭(버림)
        TRUNC(1745.9260, 2) AS "R2", --소수점 2자리 무조건 절삭(버림)
        TRUNC(1745.9260, 0) AS "R3", --소수점 없음
        TRUNC(1745.9260) AS "R4" --소수점
FROM DUAL;

SELECT ENAME, SAL, TRUNC(SAL/500,0), MOD(SAL, 500)
FROM EMP
WHERE DEPTNO = 30;

--CEIL(N) : N보다 큰 가장 작은 정수, 음수는 절대값이 작을수록 작은 수

SELECT CEIL(23.223), CEIL(-45.923)
FROM DUAL;
--FLOOR(N); N보다 작은 가장 큰 정수
SELECT FLOOR(23.223), FLOOR(-45.923)
FROM DUAL;
--POWER(M, N): M의 N제곱
SELECT POWER(3, 3), POWER(9, 3)
FROM DUAL;

--ABS(N): N의 절댓값
SELECT ABS(3), ABS(-3)
FROM DUAL;
--SQRT(N): N의 제곱근, 루트
SELECT SQRT(9), SQRT(18)
FROM DUAL;

-SIGN(N): N이 음수이면 -1, 양수이면 1, 0이면 0 출력
SELECT SIGN(-1), SIGN(1), SIGN(0)
FROM DUAL;

--날짜 함수
--SYSDATE: 오라클 서버가 운영되는 OS의 날짜와 시간을
--DATE 타입으로 반환

SELECT SYSDATE
FROM DUAL;

--WHERE절에서 날짜 형식을 주의해야 하는데, 한글 WINDOWS에 설치된 SQL-DEVELOPER는 기본이 한글이라서 YY//MM/DD로 리턴됨
--영문 07-JUN-21, 로케일에 따라 형식이 다르게 리턴됨.
--WHERE절에서 TO_DATE() 함수를 이용하여 날짜를 상수처리 권장
SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE < TO_DATE('1981-01-01', 'YY-MM-DD');

--DATE 형식의 데이터에 산술 연산하기
--날짜+숫자: TO_DATE('2009/10/04', 'YYYY/MM/DD')+3

SELECT ENAME, TRUNC((SYSDATE-HIREDATE)/7,0) AS "WEEK"
FROM EMP
WHERE DEPTNO = 30;

--MONTHS_BETWEEN('날짜1', '날짜2') 함수: 두 날짜 사이의 차이
SELECT ENAME, TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate), 0) AS "RESULT", DEPTNO
FROM EMP
WHERE DEPTNO = 30
ORDER BY RESULT DESC;

--NEXT_DAY('날짜', '요일') 함수
--날짜 기준으로 다음에 오는 요일의 날짜 변환
SELECT NEXT_DAY(TO_DATE('21/06/07', 'YY/MM/DD'), '금요일')
FROM DUAL;

-- ADD_MONTHS('날짜', '숫자') 함수
-- 숫자만큼 달 수를 더한 날짜를 반환

--LAST_DAY('날짜') 함수: 날짜가 포함된 달의 맨 마지막 날
SELECT LAST_DAY(TO_DATE('2000-02-15', 'YYYY-MM-DD'))
FROM DUAL;
SELECT LAST_DAY(TO_DATE('2001-02-29', 'YYYY-MM-DD'))
FROM DUAL;

--날짜 ROUND() 반올림, TRUNC() 버림
--실습을 위해 세션 날짜 표시 형식을 바꿈
--접속해제하면 원래대로 돌아온다.
ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD';

--ROUND()
SELECT SYSDATE, ROUND(SYSDATE, 'YEAR')
FROM DUAL;

--TRUNC()
SELECT SYSDATE, TRUNC(SYSDATE, 'YEAR')
FROM DUAL;

/*
VARCHAR OR CHAR -> NUMBER: 숫자로 된 문자만 숫자로 자동 벼환
VARCHAR OR CHAR -> DATE: 세션의 DATE 표시 형식과 일치하
*/

SELECT '1' + '1' AS "RESULT1", 1||1 AS "RESULT2"
FROM DUAL;

-- TO_CHAR(), TO_DATE(), TO_NUMBER() 사용해서 명시적으로 변환해라..

/* 날짜 포맷
YYYY: 4자리 숫자 연도
YY: 2자리 연도(2000년도)
RR: 2자리 연도(1900년도)
YEAR: 영어로 표시한 연도.

MM: 숫자로 된 월 EX) 12
MONTH: 달이름. 영어: June, 한국어: 6월
MON: 3자리 약어, 영어: JUN, 한국어: 6월

DD : 숫자로 된 달의 일
DAY : 요일(영어 : MONDAY, 한국어 : 월요일)
DY : 3자리 약어 (영어 : MON, 한국어 : 월)

HH24 : 숫자로 된 시간 (24시간 표기법)
HH, HH12 : 숫자로 된 시간 (12시간 표기법)
MI : 숫자로 된 분
SS : 숫자로 된 초
AM : 오전/오후 (영어 : AM/PM, 한국어 : 오전/오후)

*/

/* 숫자 형식 표현
9(또는 0): 자리 수: 999,999: 숫자를 최대 만 단위까지 표현
0:자리수: 099,999: 사용되지 앟는 자리를 0으로 채워라.
$:달러: $99,999: 숫자앞에 $를 표시한다.
L 지역 화폐: L999,999 해당 지역 통화 단위를 앞에 표시
. 소수점 : 999.99 소수점을 의미
, 천 단위 구분자 : 99,999 숫자에 천 단위 구분자를 표시
*/

-- 데이터 변환 함수
--TO_DATE('날짜 문자열, '날짜 형식 모델'[, 'NLS_PARAM']) 함수
--날짜처럼 표시된 문자 값에 해당한는 형식 모델을 명시하여,
--문자 값을 날짜데이터 유형으로 반환한다.
--'01-SEP-95' 날짜와 '1994/01/11' 날짜 사이의 달 수를 구하라
--MONTHS_BETWEEN() 함수 사용
--날짜-시간 상수를 명시하는 경우 TO_DATE 처리를 해야
--세션의 표시 형식에 관계없이 정상적인 결과를 얻을 수 있다.
--'01-SEP-95'날짜와 '1994/01/11'날짜 사이의 달수를 구하시오.
SELECT
MONTHS_BETWEEN
       (TO_DATE('1995/09/11','YYYY/MM/DD'),
        TO_DATE('1994/01/11','YYYY/MM/DD') ) AS "RESULT"
FROM DUAL;
--TO_ CHAR(숫자형식)', '날짜 또는 숫자 형식', 날짜 또는 숫자 형식 모델)
--SYSTDATE 함수 처리 결과를 세션의 표시 형식이 아닌 사용자가

SELECT SYSDATE, TO_CHAR(SYSDATE, 
'YYYY/MON/DD HH24:MI:SS AM DAY')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" HH"시" MI"분 "SS"초 "AM DAY') AS 날짜
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-mON-DD,') AS 날짜
FROM DUAL;

--첫번째 글자가 소문자 : 전체가 소문자로 출력됨.
--첫번째 글자가 대문자, 두번째 글자도 대문자 : 전부 대문자출력
--첫번째 글자가 대문자, 두번째 글자는 소문자 : 
--      첫글자만 대문자, 나머지 소문자.
--숫자로 표시되는 년,월,일,시간,분,초 에서 한자리만 사용하는 경우
--남은 자리는 0[ZERO]로 채운다.(예. 2021/06/08 ...)
--fm을 명시하면 0으로 채우지 않는다.
SELECT TO_CHAR(SYSDATE, 'fmYYYY-MM-DD FMhh:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh:MI:SS')
FROM DUAL;

-SP옵션(숫자를 영문으로표시), TH옵션(숫자를 영어의 TH형으로 표시)
SELECT TO_CHAR(SYSDATE, 'yYyySP-Mmspth-DDspth')
FROM DUAL;

--EMP에서 SAL 컬럼 값에 $ 또는 언화로 숫자 천단위에 , 표시
SELECT ENAME, TO_CHAR(SAL, '$9,999.99'), TO_CHAR(SAL*1200, 'L9,999,999.99')
FROM EMP;

--MI(음수일 때-를 뒤에 표시), PR(음수의 절댓값을 <>로 감싼다)
--MI, PR 동시 사용 불가.
Select to_char(0-SAL, '99,999.99MI'),
        to_char(0-SAL, '99,999.99PR')
FROM EMP
WHERE EMPNO=7839;

--9, 0 형식 모델 사용시 표시 결과의 차이
--0을 넣으면 비어잇는 자리수는 0으로 채워라

SELECT TO_CHAR(SAL, '$999,999,999.99'),
    TO_CHAR(SAL, '$099,999,999.99')
FROM EMP
WHERE EMPNO = 7839;

--9로 지정한 자리수 작으면 ########로 표시됨..
SELECT TO_CHAR(SAL, '$999,999,999.99'),
    TO_CHAR(SAL, '$099,999,999.99')
FROM EMP
WHERE EMPNO = 7839;

SELECT
    TO_CHAR(SYSDATE, 'YYYY'),
    TO_CHAR(SYSDATE, 'MM'),
    TO_CHAR(SYSDATE, 'DD'),
    TO_CHAR(SYSDATE, 'DAY'),
    TO_CHAR(SYSDATE, 'HH24:MI:SS')
FROM DUAL;

--TO_NUMBR('숫자 문자열', '숫자형식 모델') 함수
-- 명시된 숫자 문자열을 숫자 데이터형으로 변환
--'$12,000' 문자열 값에 0.1을 곱한 값을 표시하시오.
SELECT TO_NUMBER('$12,000',  '$999,999') *0.1 AS RESULT
FROM DUAL;

--단일행 함수의 중첩: 제한 없이 여러분 중첩 가능
--EMP에서 DEPTNO30인 사원의 이름을 소문자로 변경해서
--이름 끝에 _사원을 붙여서 출력해보자.

SELECT ENAME, INITCAP(CONCAT(SUBSTR(ENAME,1,3), 'MAN'))
FROM EMP
WHERE DEPTNO=30;

--일반 함수(GENERAL FUNCTION)
--NVL(), DECODE(), CASE표현식, NVL2(), NULLIF(), COALESCE() 등등...
--NVL(컬럼명, 대체값) 함수

SELECT ENAME, SAL, COMM, SAL*12 AS 연봉1,
        SAL*12+NVL(COMM,100) AS 연봉2
FROM EMP
WHERE COMM IS NULL;

--DECODE(컬럼, 값1, 표현식1, ..., 값N, 표현식N) 함수
--오라클에만 있음

SELECT ENAME,JOB,SAL,DECODE(JOB, 'CLERK', 1.20*SAL, 'SALESMAN', 1.10*SAL, 'MANAGER', 0.95*SAL, SAL) AS 연봉인상
FROM EMP
WHERE JOB IN ('CLERK', 'SALESMAN', 'MANAGER')
ORDER BY JOB;


--case 표현식 대부분의 DB에서 지원한다. 
SELECT ENAME,JOB,SAL,(CASE JOB WHEN 'CLERK' THEN 1.20*SAL WHEN 'SALESMAN' THEN 1.10*SAL WHEN 'MANAGER' THEN 0.95*SAL ELSE SAL END) AS 연봉인상
FROM EMP
WHERE JOB IN ('CLERK', 'SALESMAN', 'MANAGER')
ORDER BY JOB;

--EXTENDED CASE EXPRESSION

SELECT ENAME, SAL, (CASE WHEN SAL <1000 THEN 'Low' WHEN SAL<2500 THEN 'MEDIUM' WHEN SAL<5500 THEN 'GOOD' ELSE 'EXCELLENT' END) AS 급여등급
FROM EMP
ORDER BY SAL;

--NVL2(컬럼 이름, 대체값1, 대체값2) 함수(9I부터 지원)
-- 컬럼의 데이터가 존재하면 대체값1, 컬럼이 NULL이면 대체값2
-- 대체값1, 대체값2가 같은 데이터 유형이어야 한다.
Select ENAME, COMM, NVL2(COMM, 'OK', 'NO') AS 커미션유무
FROM EMP;


--NULLIF(컬럼1, 컬럼2) 함수 (9i부터 지원)
--컬럼1, 컬럼2의 값이 다르면, 무조건 컬럼1을 표시하고,
--두 값이 값으면 NULL을 반환한다. 두 컬럼의 데이터유형은 동일

SELECT
ENAME, LENGTH(ENAME) AS EXP1, JOB, LENGTH(JOB) AS EXP2, NULLIF(LENGTH(ENAME), LENGTH(JOB)) AS RESULT
FROM EMP;

--coalesce(컬럼exp1, 컬럼exp2, ..., 컬럼expn) 함수
--함수 내에 명시된 컬럼 값을 확인해서 최초로 null이 아닌
--컬림 expr의 값을 표시

SELECT
COALESCE('A', 'B', 'C')
COALESCE(NULL, 'B', 'C')
COALESCE(NULL, NULL, 'C')
COALESCE(NULL, NULL, NULL)
FROM DUAL;

--다중행 함수(MULTIPLE-ROW FUNCTION, GROUP FUNCTION)
--SUM(), AVG(), MAX(), MIN(), COUNT()
--VARIANCE: 분산 
--STDDEV(): 표준편차

--COUNT():행의 수를 계산

SELECT
COUNT(COMM) AS R1, COUNT(NVL(COMM, 0))AS R2
FROM EMP;

SELECT AVG(SAL) AS 평균급여, ROUND(AVG(SAL)) AS 평균급여
FROM EMP;

-- SUM(): 컬럼의 합계를 구한다.
SELECT
SUM(SAL) AS "급여총액"
FROM EMP;

--MAX():최댓값, MIN():최솟값
SELECT  MAX(HIREDATE), MIN(HIREDATE)
FROM EMP;

--10번, 20번 부서에 근무하는 직원의 부서별 평균 급여를 구해보자

SELECT 10 AS DEPTNO, AVG(SAL) AS 평균급여
FROM EMP
WHERE DEPTNO=10
UNION ALL -- 두 개의 SELECT문을 처리한 결과를 합쳐서 표현
SELECT 20, AVG(SAL)
FROM EMP
WHERE DEPTNO=20;

SELECT DEPTNO, ROUND(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;

--둘 이 상 컬럼의 GROUP BY절 
--EMP DEPTNO 30인 행들의 부서번호, JOB, SAL
SELECT JOB DEPTNO, JOB, SAL
FROM EMP
ORDER BY 1, 2;

SELECT DEPTNO, JOB, AVG(SAL) AS AVGSAL, COUNT(*) AS PERSON
FROM EMP
WHERE DEPTNO = 30
GROUP BY DEPTNO, JOB;

/* GROUP BY 절의 주의점 AVG
SELECT COL1, COL2, ... COLN, AVG(COLX)
FROM TABLENAME
GROUP BY COL1, COL2, ... COLN
SELECT절에 명시된 모든 COL은 GROUP BY절에서도 명시돼야 한다.
*/


SELECT
DEPTNO, JOB, AVG(SAL), COUNT(*)
FROM EMP
WHERE DEPTNO IN(10, 20, 30)
GROUP BY DEPTNO, JOB
ORDER BY 1,2;

SELECT DEPTNO, COUNT(ENAME)
FROM EMP
GROUP BY DEPTNO;



-- SA가 포함된 직책에 대해서 부서별 임금으 ㅣ합계, 평균임금, 근무 인원수를 구해보자.
SELECT SUM(SAL), ROUND(AVG(SAL)), COUNT(*)
FROM EMP
WHERE JOB LIKE 'SA%'
GROUP BY DEPTNO;



-- 부서별 임금의 합계가 7000보다 큰 부서에 대해서만 임금의 합계를 
SELECT DEPTNO, SUM(SAL), ROUND(AVG(SAL)), COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) > 7000
ORDER BY DEPTNO; 


---그룹 함수의 중첩은 2번까지만 가능..

-- EMP에 부서별 임금합계 중 가장 큰 부서를 구하시오
SELECT MAX(SUM(SAL)) AS 총급여가가장높은부서
FROM EMP
GROUP BY DEPTNO;

SELECT ENAME, MAX(SAL)
FROM EMP
GROUP BY ENAME, SAL;


/*
3개의 유니크한 키
1. 기본키: 테이블을 대표하는 키 EMP 테이블: EMPNO, DEPT: DEPTNO
2. 외래키: 다른 테이블의 기본키 EMP테이블: DEPTNO
3. 슈퍼키: 유니크한 성질을 같는 PRIMARY KEY 후보 
*/

SELECT  DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO;

/*
JOIN: 조건을 디준으로 두 테이블의 가 행들을 합친후, 원하는 데이터 레코드를 가져오는 방법이다.
1. INNER JOIN - EQUI-INNER JOIN NON-EQUI INNER JOIN
2. OUTER JOIN
3. CROSS JOIN 
*/
-- 조건에 '=' 연산자를 사용한다.
-- EMP, DEPT 테이블을 이용해서 조인을 해보자.
-- 사원의 사번, 이름, 부서명을 조회해서 출력
-- 조건이 명시되지 않아서 가능한 모든 표현이 리턴됨. 

SELECT
EMPNO, ENAME,  DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;


SELECT DISTINCT DEPTNO
FROM EMP;
SELECT DISTINCT DEPTNO
FROM DEPT;

SELECT
    *
FROM DEPT;

SELECT
E.EMPNO, E.ENAME, D.DNAME, E.DEPTNO
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT
E.EMPNO, E.ENAME, D.DNAME, E.DEPTNO
FROM EMP E JOIN DEPT D
ON (E.DEPTNO = D.DEPTNO);

/* EQUI 조인 표현식
SELECT T1.COL1, T1.COL2, T2.COL3, T2.COL4
FROM TABLE T1, TABLE T2
WHERE T1.PRIMARYKEY = T2.FOREIGNKEY
*/

-- non-equi join
SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL >= S.LOSAL AND E.SAL <= S.HISAL;

SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
SELECT *
FROM SALGRADE;

-- 3중조인: 테이블 3개를 조인
-- 사원번호, 이름, 부서번호, 급여 ,급여 등급을 출력 
-- E.EMPNO, E.ENAME, E.DEPTNO, D. DNAME, E.SLA, S.SALGRADE

SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, E.SAL, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO AND E.SAL BETWEEN S.LOSAL AND S.HISAL;
