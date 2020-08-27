-- SQLD part03 106p~147p

-- DBMS
-- 게층형 데이터베이스 : Tree형태 자료구조에 데이터를 저장/관리
-- 네트워크형 데이터베이스 : owner / member형태로 데이터 저장
-- 관계형 데이터베이스 : 릴레이션에 DATA 저장/관리/집합연산/관계연산/1대N관계표현
-- Oracle, MySQL, MSSQL, Sybase 등등

-- <관계형 데이터베이스(RDBMS)>
-- [집합연산]
--	합집합(Union) : 두 개의 릴레이션을 하나로 합쳐서 중복된 행(튜플)은 한번만 조회
--	차집합(Difference) : 본래 릴레이션에 존재하고 다른 릴레이션에 존재하지 않는 것을 조회
--	교집합(Intersection) : 두 개의 릴레이션 간에 공통된 것을 조회
--	곱집합(Cartesian product) : 각 릴레이션에 존재하는 모든 데이터를 조합하여 연산

-- [관계연산]
--	선택연산(Selection) : 릴레이션에 조건에 맞는 행(튜플)만 조회
--	투영연산(Projection) : 릴레이션에 조건에 맞는 속상만 조회
--	결합연산(Join) :여러 릴레이션의 공통된 속성을 사용해서 새로운 릴레이션을 만듬
--	나누기연산(Division) : 기준 릴레이션에서 나누는 릴레이션이 가지고 있는 속성과 동일한 값을 가지는 행을 ㅜ출, 나누는 릴레이션의 속성을 삭제한 후 중복 행 제거

-- <테이블 구조>
-- 기본키를 가지고 있다.
-- 행과 컬럼으로 이루어져 있다.
-- 컬럼은 필드로 속성이라고도 한다.
-- 외래키는 다른 테이블의 기본키를 참조한다.
-- 외래키는 관계연산 중 결합연산(조인)을 하기 위해 사용된다.

-- < SQL(Structured Query Language) >
--	데이터구조를 정의, 제어, 조작할 수 있는 잘차형 언어
--	ANSI/ISO 표준 : INNER JOIN, NATUAL JOIN, USING 조건, ON 조건절 사용

-- SQL종류
--	DDL : 데이터 정의 / CREATE, ALTERT, DROP, RENAME 
--	DML : 데이터 조작 / INSERT, UPDATE, DELETE, SELECT
--	DCL : 데이터 제어 / GRANTE, REVOKE
--	TCL : 트랜잭션 제어 / COMMIT / ROLLBACK
-- 실행순서 : 파싱 => 실행 => 인출

-- <트랜잭션의 특징>
--	원자성 : DB연산이 모두 실행 OR 모두 미실행 / 트랜잭션 처리가 끝나지 않으면 실행되지 않은 처음과 같아야함. 
--	일관성 : 트랜잭션 실행 결과로 DB상태가 모순되지않아야함. / 트랜잭션 실행 후에도 일관성 있게 유지
--	고립성 : 트랜잭션 실행 중에 다른 트랜잭션이 접근 불가
--	영속성 : 트랜잭션 성공 시 영구적 보장 

--<CRUD>--

-- 테이블명 변경
ALTER TABLE EMP RENAME TO NEW_EMP;
ALTER TABLE NEW_EMP RENAME TO EMP;
-- 컬럼 추가
ALTER TABLE EMP ADD(AGE VARCHAR2(20));
-- 컬럼명 변경
ALTER TABLE EMP RENAME COLUMN AGE TO AGE1;
-- 컬럼 타입 , 길이, 제약조건 변경
ALTER TABLE EMP MODIFY(AGE VARCHAR2(10));
-- 컬럼 삭제
ALTER TABLE EMP DROP COLUMN AGE;

-- 테이블 만들기
CREATE TABLE TEST(
	NAME VARCHAR2(10) NOT NULL,
	AGE NUMBER UNIQUE,
	ADDR VARCHAR2(10)
);
-- 특정 컬럼에 값넣기
INSERT INTO TEST(NAME, AGE)
VALUES('JIHU', 10);

-- INSERT하기
INSERT INTO TEST VALUES('JIHU1', 20, 'INCHEON');

-- 특정 컬럼 조회
SELECT * FROM TEST WHERE NAME = 'JIHU';

-- 전체 컬럼 조회
SELECT * FROM TEST;

-- 테이블 용량까지 삭제
TRUNCATE TABLE TEST;
DROP TABLE TEST;


-- ORDER BY : 정렬 / DESC : 내림차순 / ACS : 오름차순
SELECT EMPNO FROM EMP ORDER BY EMPNO DESC;

-- DISTINCT : 중복된 값 제거하고 조회하기
SELECT DEPTNO FROM EMP;
SELECT DISTINCT DEPTNO FROM EMP;

-- NVL함수 SELECT
SELECT NVL(COMM, 0) FROM EMP;
SELECT NVL2(COMM, 1, 0) FROM EMP;
SELECT NULLIF(300, 300) FROM EMP;
SELECT COALESCE(NULL, 2,4) FROM EMP;

-- 집계함수 사용하기
SELECT JOB, AVG(SAL) FROM EMP
GROUP BY JOB;


-- < 연산자 >
-- 같지 않는 것을 조회 : !=, ^=, <>, NOT 컬럼명, 
-- 크지 않은 것을 조회 : NOT 컬럼명 >

-- 논리연산자
--	AND : 조건을 모두 만족해야 TRUE
--	OR : 조건 중 하나만 맞아도 TRUE
--	NOT : 참이면 거짓으로, 거짓이면 참으로

-- SQL연산자
--	LIKE %비교문자열% : 비교문자열이 포함된거 출력
--	BETWEEN A AND B : A와 B 사이
--	IN : OR을 의미하고 list값 중 하나만 일치해도 조회함
--	IS NULL : NULL값 조회

-- 부정SQL연산자
--	NOT BETWEEN A AND B : A와 B사이가 아닌애들 조회
--	NOT IN : list와 불일치한 것 조회
--	IS NOT NULL : NULL값이 아닌애들 조회

-- S로 시작하는 ENAME 조회. LIKE 사용
SELECT ENAME FROM EMP WHERE ENAME LIKE 'S%';
-- S로 끝나는 ENAME 조회. LIKE 사용
SELECT ENAME FROM EMP WHERE ENAME LIKE '%S';
-- S가 호팜되는 ENAME 조회. LIKE 사용
SELECT ENAME FROM EMP WHERE ENAME LIKE '%S%';

-- TEST_ NAME이 TEST 후고 뒤에 한글자 더 오는 애 조회하기
SELECT NAME FROM TEST WHERE NAME LIKE 'JIHU_';

-- IN을 이용해서 조회 / JOB CLERK, MANAGER 인 애들 출력
SELECT * FROM EMP WHERE JOB IN ('CLERK', 'MANAGER');
-- 두개의 컬럼을 동시에 조회
SELECT * FROM EMP WHERE (JOB, ENAME) IN (('CLERK', 'SMITH'), ('MANAGER', 'JONES'));

-- NULL 조회
-- 모르는 값을 의미
-- 값의 부재를 의미
-- 숫자 혹은 날짜를 더하면 NULL
-- 어떤 값을 비교할 떄 알수없음 반환
-- NULL 조회 : IS NULL / NULL아닌 값 조회 : IS NOT NULL


-- 집계함수
-- COUNT() : 행의 갯수
-- SUM() : 합계
-- AVG() : 평균
-- MAX() / MIN() : 최대 / 최소
-- STDDEV() : 표준편차
-- VARIAN() : 분산계산

-- COUNT(*) / COUNT(컬럼명)
-- 4개 출력 (NULL값 제외)
SELECT COUNT(COMM) FROM EMP;
-- 14개 출력(NULL값 포함)
SELECT COUNT(*) FROM EMP;

-- SELECT 실행 순서
-- FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY

-- 형변환
-- TO_NUMBER : 문자열을 숫자로 변환
-- TO_CHAR : 숫자 혹은 날짜를 지정된 FORMAT의 문자로 변환
-- TO_DATE : 문자열을 지정된 FORMAT의 날짜형으로 변환