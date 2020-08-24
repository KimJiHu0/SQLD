 -- Nested Join :
 -- 먼저 조회되는 Table을 Outer Table / 그 다음에 조회되는 Table를 Inner Table라고 부른다.
 -- Outer Table의 크기가 작은것부터 찾는 것이 중요하다. : 그래야 데이터가 스캔되는 범위를 줄일 수 있음.
 -- Random Access :
 -- Outer Table에서 ROWID로 읽어 온 후에 Inner Table의 인덱스를 찾는데 이 부분을 의미한다. 

  -- use_nl을 사용한 의도적으로 Nested Join을 한 경우
  -- 앞서 쓴 EMP 테이블을 FULL SCAN을 한 후에 DEPT테이블을 FULL SCAN하여 Nested Join.
  -- ordered HINT :
  -- FROM절에 나오는 테이블 순서대로 조인하는 것
  -- use_nl, use_marge, use_hash와 함께 사용된다.
 SELECT /*+ ordered use_nl */* FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
 AND E.DEPTNO = 10;
 
-- SORT MERGE JOIN

-- 두개의 테이블을 SORT AREA라는 메모리 공간에 로딩(Lodding)하고 SORT를 수행
-- SORT가 완료된 두 테이블을 MERGE(병합)한다.
-- SORT MERGE는 SORT가 발생하기 때문에 데이터양이 많으면 성능이 급격히 떨어진다.
SELECT /*+ ordered use_merge(b)*/*
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 10;

-- HASH JOIN
-- 두개의 테이블 중 크기가 ㅈ작은 테이블을 HASH메모리에 Lodding하고 두개 테이블의 조인키를 사용해서 테이블생성
-- hash함수를 사용해서 주소계산, 해당 주소를 사용해서 테이블조인
-- CPU연산을 많이하고 선행테이블은 메모리에 Lodding될 크기여야한다.
SELECT /*+ ordered use_hash(b)*/* FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 10;