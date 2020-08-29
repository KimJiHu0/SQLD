-- EQUI JOIN
-- 실행 계획 :
-- EMP, DEPT를 모두 읽은 다음에(TABLE ACCESS FULL)
-- 해쉬함수 사용해서 연결
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO
AND SAL > 2000;

-- INNER JOIN
SELECT * FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND SAL > 2000;

-- CROSS JOIN
-- 조건문이 없기 떄문에 EMP가 가진 행의 갯수 * DEPT가 가진 행의 갯수를 반환
SELECT * FROM EMP, DEPT;

-- UNION(합집합) : 중복을 제거고 정렬을 유발해.
-- UNION하려는 두 개의 테이블의 컬럼수 혹은 데이터 형식이 일치하지 않으면 오류가 발생하낟.
SELECT DEPTNO FROM EMP
UNION
SELECT DEPTNO FROM DEPT;

-- UNION ALL : 
-- UNION과 똑같은데 중복을 허용하고 정렬을 하지 않아.
SELECT DEPTNO FROM EMP
UNION ALL
SELECT DEPTNO FROM DEPT;

-- MINUS :
-- 두 개의 테이블의 차집합을 도출해.
-- 선행 테이블에는 존재하고 후행 테이블에는 존재하지 않는 집합 조회.
-- DEPT에 있는 행만 조회
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;


-- 계층형 조회
-- 계층형으로 데이터를 조회할 수 있어.
-- 사장 -> 부장 -> 차장 ... 이런식으로
-- 아래로 탐색하면서 조회 가능, 역방향도 가능.

-- CONNECT BY : Tree형태 구조로 질의 수행하는 것
-- START WITH : 시작 조건
-- CONNECT BY PRIOR : 조인 조건

-- 계층형 조회에서는 MAX(LEVEL)을 사용하여 최대계층을 구할 수 있다. 즉, 마지막 Leaf NODE의 계층값을 구한다.
SELECT EMPNO, ENAME, MGR, LEVEL FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;

-- 역방향 조회
SELECT EMPNO, ENAME, MGR, LEVEL FROM EMP
START WITH MGR IS NOT NULL
CONNECT BY PRIOR EMPNO = MGR;

SELECT LEVEL, LPAD(' ', 4 * (LEVEL-1)) || EMPNO, MGR, CONNECT_BY_ISLEAF
FROM EMP START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;



-- SUBQUERY
-- SELECT문에 SUBQUERY를 사용하는 것을 SUBQUERY라고 한다.
-- () 밖에 있는 SELECT문이 MAIN QUERY이다.
SELECT * FROM EMP WHERE DEPTNO =
(SELECT DEPTNO FROM DEPT WHERE DEPTNO = 10);

-- INLINE VIEW
-- FROM구에 SUBQUERY를 작성하는 것을 INLINE VIEW라고 한다.
SELECT ROWNUM, EMPNO, ENAME, SAL FROM
(SELECT * FROM EMP ORDER BY SAL DESC) A;


-- 단일행 서브쿼리 / 다중행 서브쿼리

-- 단일행 서브쿼리 : 결과값으로 반환되는 행의 갯수가 한개인 것 [비교연산자 : >,<,>=, <=, <>]
-- 다중행 서브쿼리 : 결과값으로 반한되는 행의 갯수가 여러개인 것 [비교연산자 : IN,ALL,ANY,EXISTS]

-- 다중행 서브쿼리 : 

-- IN
-- IN은 반환되는 여러개 행중에서 하나만 참이되어도 참이 연산된다.
-- 다중행 서브쿼리이기 때문에 SAL이 2000초과인 애들의 EMPNO를 싹다 가져왔는데
-- EMP랑 DEPT랑 조인한 애들 중에서 서브쿼리의 결과값과 맞는것들 출력
SELECT ENAME, DNAME, SAL FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
AND EMP.EMPNO IN (SELECT EMPNO FROM EMP WHERE SAL > 2000);

-- ALL
-- ALL의 조건 두개 전부 만족해야 참.
-- 아래의 경우, 20과,30 보다 작거나 같은애들 출력
-- 10,20 밖에 없기 떄문에 DEPTNO가 10,20 인 애들만 출력
SELECT * FROM EMP WHERE DEPTNO  <= ALL(20,30);

-- EXISTS
-- 서브쿼리로 어떤 데이트 존재 여부를 확인
-- SUBQUERY : EMP테이블에 SAL이 2000초과 인 애들이 있으면 TRUE
SELECT ENAME, DNAME, SAL FROM EMP JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO
AND EXISTS (SELECT 1 FROM EMP WHERE SAL > 2000);


-- 스칼라 SUBQUERY
-- 서브쿼리의 결과값이 한 행, 한 컬럼만 존재하는 서브쿼리.
-- 얘는 SELECT문에 SUBQUERY를 작성한다.
-- 스칼라 SUBQUERY의 결과값이 여러 행이면 오류.
SELECT
ENAME AS "이름",
SAL AS "월급",
(SELECT AVG(SAL) FROM EMP) AS "평균급여"
FROM EMP
WHERE ENAME = 'KING';

-- 연관 SUBQUERY
-- 서브쿼리 내에서 메인쿼리의 컬럼을 사용하는 것
SELECT * FROM EMP E
WHERE E.DEPTNO = (SELECT DEPTNO FROM DEPT D
WHERE E.DEPTNO = D.DEPTNO);


-- ROLLUP
SELECT 
DECODE(DEPTNO, NULL, '전체합계', DEPTNO) AS "부서번호",
SUM(SAL) AS "부서별합계"
FROM EMP
GROUP BY ROLLUP(DEPTNO);


SELECT DEPTNO, GROUPING(DEPTNO),
JOB, GROUPING(JOB),
SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);


SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB);

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB);

----------------------------------------------------------

-- [ 윈도우함수  ] 
-- 행과 행 간의 관계를 정의하기 위해서 제공되는 함수
-- 운수, 합계, 평균, 행 위치를 조작 할 수 있다.


-- WINDOWING함수 : 범위지정
-- EMPNO, ENAME, SAL, SUM(SAL)을 조회할건데
-- OVER로 SAL로 ORDER BY해준 후
-- ROWS로 지정해줄건데
-- BETWEEN ? AND ? : ?부터 ?까지
-- UNBOUNDED PRECEDING : 첫번째 행부터
-- UNBOUNDED FOLLOWING : 마지막행까지
SELECT
EMPNO,
ENAME,
SAL,
SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "합계" FROM EMP;


-- CURRENT ROW : 현재 행 위치까지 => 데이터가 도출된 현재 행
-- 결과적으로 누적합계를 도출한다.
SELECT
EMPNO,
ENAME,
SAL,
SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TOTAL
FROM EMP;

-- [순위함수]
-- RANK, DENSE_RANK, ROW_NUMBER

-- RANK : 동일한 값에게 동일한 순위가 부여되고, 동일한 순위를 하나의 건수로 치지 않는다.즉, 각각 하나의 순위가 부여되는 것 [ 1,2,2,3 등이 있다면  ] => [ 1,2,2,4 ]가 된다.
-- DENSE_RANK : 동일한 값에게 동일한 순위가 부여되고, 동일한 순위를 하나의 건수로 친다. 즉, 각각 하나의 순위가 부여되면서 1,2,2,3 등이면 그대로 간다는 의미.
-- ROW_NUMBER : 동일한 순위에 대해서 고유의 순위를 부여한다. 중복이 되지않고 순서대로 부여한다. 

-- RANK()함수 사용하기 : 2등이 2명인데 이는 하나의 건수로 치지 않는다.
SELECT EMPNO, ENAME, SAL, RANK() OVER(ORDER BY SAL DESC) AS "급여순위" FROM EMP;

-- DENSC_RANK() : 2등이 2명인데 하나의 건수로 친다.
SELECT EMPNO, ENAME, SAL, DENSE_RANK() OVER(ORDER BY SAL DESC) AS "급여순위" FROM EMP;

-- ROW_NUMBER : 값이 중복되던 말던 고유의 번호를 순서대로 부여한다.
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY SAL DESC) AS "고유번호" FROM EMP;


-- [ 집계함수 ]

-- AVG() : 평균
SELECT AVG(SAL) FROM EMP;
-- SUM() : 합계
SELECT SUM(SAL) FROM EMP;
-- COUNT() : NULL값을 포함한 모든 갯수
-- COUNT(컬럼명) : NULL값을 제외한 갯수
SELECT COUNT(*) FROM EMP;
SELECT COUNT(COMM) FROM EMP;
-- MAX() / MIN() : 최대값, 최소값
SELECT MAX(SAL), MIN(SAL) FROM EMP;


-- [행 순서 관련 함수]

-- FIRST_VALUE : 가장 처음에 나오는 값 <MIN함수와 동일한 결과>
-- LAST_VALUE : 가장 마지막에 나오는 값<MAX함수와 동일한 결과>
-- LAG : 이전 행을 가지고 옴.
-- LEAD : 특정 위치의 행을 가지고 옴.

-- OVER(PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) AS DEPT_A : DEPT_A 라는 파티션을 따로 만들었는데 SAL을 DESC 해준 상태에서
-- UNBOUNDED PRECEDING : 가장 첫번쨰 행을 가져온다. 결국 SAL이 가장 큰 사람의 값을 도출해낸다.
-- FIRST_VALUE : 부서 내에서 가장 월급이 많은 사람의 ENAME을 출력
SELECT DEPTNO, ENAME, SAL, FIRST_VALUE(ENAME) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) AS DEPT_A FROM EMP;

-- 위의 결과와 반대로 현재핸부터 마지막행까지 도출, SAL이 DESC인대로 DEPTNO라는 파티션을 만듬 이름은 DEPT_A
-- LAST_VALUE : 가장 마지막에 있는 행을 가져와.근데 DESC를 해줬기 때문에 가장 마지막에있는애가 가잘 숫자가 적은애
SELECT DEPTNO, ENAME, SAL,
LAST_VALUE(ENAME) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING ) AS DEPT_A
FROM EMP;

-- LAG() : 이건 값을 가져오는 것.
-- SAL의 이전값, 처음 이전값은 NULL이고, 두번쨰 PRE_SAL에는 이전 SAL의 값인 5000을 가져온다.
SELECT DEPTNO, ENAME, SAL,LAG(SAL) OVER(ORDER BY SAL DESC) AS PRE_SAL FROM EMP;

-- LEAD() : 특정한 행을 가져온다.
-- SAL컬럼의 값 중에 2번쨰 애를 가져온다.
SELECT DEPTNO, ENAME, SAL, LEAD(SAL, 2) OVER(ORDER BY SAL DESC) FROM EMP;


-- [ 비율 관련 함수 ]
-- 누적 백분율 , 순서별 백분율, 파티션을 N분으로 분할한 결과 등
-- CUME_DIST : 파티션 전체건수에서 현재행보다 작거나 같은 건수에 대한 누적 백분율 조회
-- PERCENT_RANK : 파티션에서 제일 먼저 나온 것을 0 , 제일 늦게 나온거 1로 하여 값이 아닌 행의 순서별 백분율 조회
-- NTILE : 파티션별로 전체건수를 ARGUMENT값으로 N등분한 결과 조회
-- RATIO_TO_REPORT : 파티션 내에 SUM에 대한 행 별 칼럼값의 백분울을 소수점까지 조회

-- PRECENT_RANK()
SELECT DEPTNO, ENAME, SAL, PERCENT_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS PERCENTRANK

-- NTILE() : 급여가 높은 순으로 4등분
SELECT DEPTNO, ENAME, SAL, NTILE(4) OVER(ORDER BY SAL DESC) AS N_TILE
FROM EMP;


-- [ PARTITION 기능 ]
-- 대용량 테이블을 여러개의 데이터 파일에 분리해서 저장.
-- 데이터가 물리적으로 분리된 데이터 파일에 저장되면 입력,수정,삭제,조회 성능 향상
-- PARTITION은 각각 독립적이다.즉, PARTITION별로 백업하고 복구 가능, 전용 INDEX생성가능
-- 데이터 조회 시 범위를 줄여서 성능향상

-- RANGE PARTITION
-- 컬럼 중에서 값을 범위를 기준으로 여러 파티션으로 데이터 나눠서 저장.
-- 예를들어서, SAL이 2000이상인 애들은 PARTITION01에 저장, 나머지는 PARTITION02에 저장

-- LIST PARTITION
-- 특정 값을 기준을 분할
-- 예를들어서, DEPTNO가 10번인애들은 PARTITION01 / DEPTNO가 20번인애들은 PARTITION02에 저장

-- HASH PARTITION
-- 내부적으로 HASH함수를 사용해서 데이터 분할


-- [ PARTITION INDEX ]
-- GLOBAL INDEX : 여러개의 파티션에서 하나의 인덱스를 사용해
-- LOCAL INDEX : 해당 파티션 별로 각자의 인덱스를 사용해
-- PREFIXED INDEX : 파티션 키와 인덱스 키가 동일해
-- NON PREFIXED INDEX : 파티션 키와 인덱스 키가 동일하지 않아