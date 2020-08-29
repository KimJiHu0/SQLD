-- 229P [답 제출]

-- 3번 : 테이블 생성하기
CREATE TABLE LIMBEST(
	ID VARCHAR2(10) PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL,
	AGE NUMBER(3) DEFAULT 1,
);
-- 5번 : FK를 이용해서 테이블 참조하기
CREATE TABLE 가족(
	NAME VARCHAR2(10),
	AGE VARCHAR2(10),
	부양사번 NUMBER,
	CONSTRAINT NAME_PK PRIMARY KEY(NAME),
	CONSTRAINT 부양사번_FK FOREIGN KEY(부양사번) REFERENCES 사원(사번)
);
--8번 : INDEX 생성하기
CREATE INDEX idx_mgr ON EMP(MRG);
-- 14번 : MGR 컬럼값이 NULL이면 9999출력
SELECT NVL(MGR, '9999') FROM EMP;
-- 18번 : 날짜데이터를 문자로바꾸고 문자에서 연도만 출력
SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL;
-- 23번 : SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO를   ANSI/ISO표준 SQL문으로 변경
SELECT * FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 10;
-- 25번 : EMP, DEPT테이블 컬럼들 전부 출력하기
SELECT * FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO (+)= D.DEPTNO;
SELECT * FROM EMP RIGHT OUTER JOIN DEPT 
ON EMP.DEPTNO = DEPT.DEPTNO;

---------------------------------------

--오답정리하기
--5번
CREATE TABLE 가족(
	이름 VARCHAR2(20),
	부양사번 VARCHAR2(20),
	나이 NUMBER DEFAULT 1,
	CONSTRAINT 이름_PK PRIMARY KEY(이름),
	CONSTRAINT 부양사번_FK FOREIGN KEY (부양사번) REFERENCES 사원(부양사번)
);
-- 8번
CREATE INDEX idx_mgr ON EMP(MGR);

-- 11번
-- TRUNCATE TABLE에 대한 설명으로 올바르지 않는 것은? 2
-- 1. WHERE을 지정할 수 없다.
-- 2. 외래키 무셜성을 확인한다.
-- 3. ROLLBACK이 될 수 없다.
-- 4. 자동으로 COMMIT한다.
-- [해설]
-- WHERE절을 지정할 수 없고, ROLLBACK이 될 수 없고, 자동으로 COMMIT된다.
-- TRUNCATE TABLE는 외래기 무결성을 확인하지 않고
-- TABLE에 대해서 LOCK을 획득 후 일괄적으로 빠르게 삭제한다.
-- 또, TRUNCATE TABLE로 삭제를 실시하면 테이블 용량도 초기회된다.

-- 12번
-- SELECT 20 + 10, 20 + NULL, NULL + 20 FROM DUAL; 의 결과는?
-- 결과 : 30,NULL,NULL
-- 해설 : 숫자와 NULL을 연산하게 되면 NULL이 반환된다.

-- 20번
-- SELECT 1 FROM DUAL UNION SELECT FROM 2 FROM DUAL UNION SELECT 1 FROM DUAL; 실행결과는? 1
-- 1. 1,2
-- 2. 1,2,1
-- 3. 2,1
-- 4. 1
-- [해설]
-- UNION은 합집합을 만든다. 1과2와1을 합해서 출력해주는데 이 떄 중복은 제거하고 SORT를 유발한다.

-- 22번
-- 표준 편차를 집계하는 집계함수는 ? 3
-- 1. AVG() 2. SUM() 3. STDDEV() 4. VARIAN()
-- [해설]
-- AVG() : 평균 / SUM() : 합산 / VARIAN() : 분산을 계산

-- 26번
-- SELECT ROUND(10.51234,1) FROM DUAL; 의 실행결과는? 2
-- 1. 10 2. 10.5 3. 10.51 4. 11
--[해설]
-- ROUND를 해주는데 소수점 첫째자리까지 해달라고 했으니까 10.5

-- 28번
-- CONNECT BY에 대한 설명으로 올바르지 않는것은? 1
-- 1. CONNECT_BY_ISLEAF는 전개과정에서 Leaf 데이터면 0, 아니면 1을 가진다.
-- 2. CONNECT_BY_ISCYCLE는 Root까지의 경로에 존재하는 데이터를 의미한다.
-- 3. CONNECT_BY_ROOT는 Root 노드의 정보를 표시한다.
-- 4. SYS_CONNECT_BY_PATH는 하위 레벨의 칼럼까지 모두 표시한다.
--[해설]
-- CONNECT_BY_ISLEAF는 전개과정에서 Leaf 데이텨면 1, 아니면 0을 가진다.

-- 30번
-- SELECT * FROM EMP WHERE EMPNO LIKE '100%'; 의 결과로 올바르지 않는것은?(EMPNO는 기본키, 숫자) 1
-- 1. EMP 테이블을 FULL SCAN한 것은 인덱스가 없어서다.
-- 2. 내부적으로 형변환이 발생했다.
-- 3. LIKE조건을 사용하지말고 ">"조건을 사용해야한다.
-- 4. 기능상으로는 문제가 없지만 , 성능으로 문제가 있다.
--[해설]
-- EMPNO는 기본키라서 자동으로 인덱스가 생성된다. 그런데 FULL SCAN이 된 것으로 LIKE조건에서  숫자 칼럼과 문제값 간에 형변환이 발생해서다.