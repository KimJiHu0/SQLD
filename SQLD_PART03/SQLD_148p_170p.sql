-- SQLD part03 148p ~ 170p


-- 내장함수

-- 나머지계산
SELECT MOD(7,4) FROM DUAL;
-- 절대값
SELECT ABS(-1000) FROM DUAL;
-- 음수, 0 ,양수 그ㅜ별
SELECT SIGN(0) FROM DUAL;
-- 지정된 숫자보다 크거나 같은 최소 정수
SELECT CEIL(10.8) FROM DUAL;
-- 지정된 숫자보다 작거나 같은 최대 정수
SELECT FLOOR(10.3) FROM DUAL;
-- 지정한 소수점자리에서 반올림
SELECT ROUND(10.345, 2) FROM DUAL;
-- 지정한 소수점 자리에서 절삭
SELECT TRUNC(10.345, 2) FROM DUAL;



SELECT * FROM EMP;
-- DECODE : EMPNO가 7499인게 참이면 '참'출력, 거짓이면 '거짓'출력
SELECT DECODE(EMPNO, '7499', '참', '거짓') FROM EMP;

-- CASE : 
-- CASE WHEN : SAL이 1000 미만일 떄
-- THEN : '하급' 출력
-- ELSE : 그게 아닐때 '고급' 출력
-- END : CASE문 종료
SELECT CASE WHEN SAL < 1000 THEN '하급' ELSE '고급' END FROM EMP;


-- ROWNUM : 논리적인 고유 번호
-- 서브쿼리 문 안에있는 SAL을 DESC로 정렬해준 후에
-- 메인쿼리에서 ROWNUM을 출력한다.
-- ROWNUM은 한 행 혹은 5 미만의 값 이런식으로 가져올 수 있지만
-- 중간에 있는 값을 가져올 수 없다.
-- 그러기 위해선 
SELECT ROWNUM, ENAME, SAL FROM (SELECT * FROM EMP ORDER BY SAL DESC) A;
SELECT ROWNUM, ENAME, SAL FROM EMP WHERE ROWNUM < 5;


-- ROWID : 데이터를 구분할 수 있는 유일한 행의 고유번호?
SELECT ROWID FROM EMP;

-- WITH : 서브쿼리를 사용해서 임시 TABLE이나 VIEW를 만든다.
WITH W_EMP AS
(SELECT * FROM EMP WHERE DEPTNO = 30)
SELECT * FROM W_EMP;



-- DCL (데이터 제어)
-- GRANT : 
-- 부여 가능한 권한
-- SELECT : 조회
-- INSERT : 입력
-- UPDATE : 수정
-- DELETE : 삭제
-- REFERENCES : 제약조건 생성
-- ALTER : 테이블 수정
-- INDEX : INDEX생성
-- ALL : 전부 다

-- GRANT로 권한을 부여할건데 , 조회, 입력, 수정, 삭제를 부여
-- ON EMP : EMP테이블에 대해서.
-- TO TEST1 : TEST1이라는 사용자에게.
GRANT SELECT, INSERT, UPDATE, DELETE ON EMP TO TEST1;

-- EMP테이블에 대한 조회, 입력, 수정, 삭제 권한을 TEST1이라는 사용자에게 준다.
-- WITH GRANT OPTION :
-- A라는 사용자가 B라는 사용자에게 권한을 부여할 권한을 줬다. 그리고 B라는 사용자가 C라는 사용자에게 권한을 부여했다.
-- 이 떄 A라는 사용자가 B라는 사용자의 권한을 REVOKE(취소)한다면 사용자 B와 C도 권한 취소.
GRANT SELECT, INSERT, UPDATE, DELETE ON EMP TO TEST1 WITH GRANT OPTION;

-- EMP테이블에 대한 조회, 입력, 수정, 삭제를 TEST1이라는 사용자에게 권한 부여.
-- WITH ADMIN OPTION : 
-- A라는 사용자가 B라는 사용자에게 아래와 같이 권한을 부여했다.
-- B라는 사용자는 C라는 사용자에게 권한을 부여했다.
-- 이 떄 A라는 사용자가 B라는 사용자에 대한 권한을 REVOKE(취소)했을 때
-- C라는 사용자의 권한은 유지가 된다.
GRANT SELECT, INSERT, UPDATE, DELETE ON EMP TO TEST1 WITH ADMIN OPTION;