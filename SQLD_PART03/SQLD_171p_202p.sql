--ROWNUM SUBQUERY�� ����ϱ�
SELECT * FROM
(SELECT EMPNO, ENAME, SAL , ROWNUM A FROM EMP);

--ROWID
SELECT ROWID, EMPNO FROM EMP;

--WITH �ӽ����̺�
WITH W_EMP AS
(SELECT * FROM DEPT WHERE DEPTNO = 30)
SELECT * FROM W_EMP;

-- EQUI JOIN
SELECT * FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- INNERJOIN
SELECT * FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO
AND SAL > 2500;

-- INTERSECT : �� ���̺��� ������ ã�� [ �� ���̺��� ����� COLUMN�� DEPTNO�̴�.�̸� ��ȸ�Ѵ�. ] <INTERSECT> 
SELECT DEPTNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT;

-- �����(EQUI)�� "=" �� �̿��ؼ� ���� ��(������)�� ��ȸ�ϰ� / ������(Non-EQUI)�� <, >, >=, <=�� �̿��ؼ� ��Ȯ���� ���� �������ش�.

-- OUTER JOIN
SELECT * FROM DEPT, EMP
WHERE DEPT.DEPTNO (+)= EMP.DEPTNO ;

--LEFT OUTER JOIN : DEPT���̺�� EMP���̺��� ����� ���� ����ȸ�ϸ鼭 �������̺� �ִ� �͸� ��ȸ�Ѥ�.
SELECT * FROM DEPT LEFT OUTER JOIN EMP
ON DEPT.DEPTNO = EMP.DEPTNO;

SELECT * FROM EMP;
SELECT * FROM DEPT;

-- RIGHT OUTER JOIN
SELECT * FROM DEPT RIGHT OUTER JOIN EMP
ON EMP.DEPTNO = DEPT.DEPTNO;

-- CROSS JOIN : WHERE OR ON ���� �ΰ��� ���̺��� JOIN�� ���������� �̷� �� "ī�׽þ� ��"�� �߻��ؼ� EMP���̺��� 12���� �� + DEPT���̺��� 4�������� �������� 48���� ���´�.
SELECT * FROM EMP CROSS JOIN DEPT;

-- UNION : �������̴�. �ߺ������͸� �����ϰ� SORT�ϰ� ���.
-- 			UNION�� ���ַ��� 2���� ���̺��� �� ������ ����, TYPE�� ���ƾ��Ѵ�.
SELECT * FROM EMP
UNION
SELECT * FROM EMP;

-- UNION ALL : �ߺ������� ����X , ����X : �ߺ��� ���ŵ��� �ʾƼ� 24���� ���� ���.
SELECT * FROM EMP
UNION ALL
SELECT * FROM EMP;

-- MINUS : ó�� SELECT TALBE���� �ְ� ���� SELECT TABLE���� ���� ������ ��ȸ
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;
-- DEPT�� DEPTNO�� 10,20,30,40�� �ְ� EMP���� DEPTNO�� 10,20,30�� �ִ�.
-- ó�� SELECT TABLE�� �ְ�, 10,20,30,40
-- ���� SELECT TABLE���� ���� 10,20,30�� �־ 40�� ����? �׷� 40���


-- ������ ��ȸ.
SELECT MAX(LEVEL)
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR  EMPNO = MGR;

-- SUBQUERY
SELECT * FROM EMP --MAIN QUERY
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DEPTNO = 10); -- SUBQUERY

-- INLINE VIEW(FROM���� SELECT���� ����)
SELECT * FROM (SELECT DEPTNO FROM DEPT);

-- IN������ : SUBQUERY�� ����� �ϳ��� ���� �Ǿ ���� �Ǵ� ����
SELECT ENAME, DNAME, SAL FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
AND EMP.EMPNO IN (SELECT EMPNO FROM EMP WHERE SAL > 2000);

-- ALL������ : MAIN QUERY , SUB QUERY ����� ��� �����ϸ� ��
-- DEPTNO�� 20,30�� ���ų� �����ֵ��� �ֵ��� ������ ��ȸ.
SELECT * FROM EMP
WHERE DEPTNO <= ALL(20,30);
-- DEPTNO�� 20���� ū �ֵ��� ��ȸ�Ѵ�.
SELECT * FROM EMP
WHERE DEPTNO > ALL(20);

-- EXISTS : SUBQUERY�� � ������ ���� ���� Ȯ��
-- ���� ����� ��, ������ ��ȯ
SELECT ENAME, DNAME, SAL
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
AND EXISTS (SELECT * FROM EMP WHERE SAL > 2000);

-- SCALA SUBQUERY : �ݵ�� �� ��� �� �÷��� ��ȯ�Ǵ� SUBQUERY / ���� ������ ���� ��� ����
SELECT ENAME, SAL, (SELECT AVG(SAL) FROM EMP)
FROM EMP;

-- CORRELATED(����) SUBQUERY : SUBQUERY ���� MAIN QUERY�� COLUMN�� ����ϴ� ���� �ǹ�
SELECT * FROM EMP E
WHERE E.DEPTNO = (SELECT DEPTNO FROM DEPT D
WHERE E.DEPTNO = D.DEPTNO );

-- ROLLUP : GROUP BY�� ���� COLUMN�� SUBTOTAL�� ���Ѵ�.
-- ���� ��� �̰������� �μ��� ��տ����� ���߰�
-- GROUP BY ROLLUP(DEPTNO) => GROUPY BY�� ������ DEPTNO�� ROLLUP���ְڴٴ� ���̶�� �� �� �ִ�.
SELECT DECODE(DEPTNO, NULL, '��ü�հ�', DEPTNO) AS �μ�, SUM(SAL) AS ��տ��� FROM EMP
GROUP BY ROLLUP (DEPTNO);
-- �μ���, ������ ��հ� ��ü�հ�.
SELECT DEPTNO, JOB, SUM(SAL) FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

--GROUPING SETS
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY GROUPING SETS(JOB, DEPTNO)

-- CUBE : ROLLUP �� ����� �� ��θ� ��� [ EX ] = �μ��� ������ �����̸�, �μ��� ����, ����������, �μ� ������ ����, ��ü�հ� ��ȸ
SELECT DEPTNO, JOB, SUM(SAL) FROM EMP
GROUP BY CUBE(DEPTNO, JOB)

-- RANK : ������ ������ ������ �� �ο� [EX] SAL�� 1000�� 2���̸� �Ѵ� 1, 1 �ο�
SELECT ENAME, SAL, RANK() OVER(ORDER BY SAL DESC) AS �޿�����, -- �޿������� RANK�Լ��� ����ؼ� ���. SAL�� DESC���ְ�, RANK�� �ο�.(������ ���� ���ϼ�����.)
RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) AS ���������� -- JOB���� PARTITION�� ����� JOB�� ���� ��ȸ
FROM EMP; 
-- DENSE_RANK : ������ ������ �ϳ��� �Ǽ��� �ο� [EX] SAL�� 1000�� 2���̸� 1 �ϳ��� �ο�
SELECT ENAME, SAL,
RANK() OVER(ORDER BY SAL DESC) AS ALL_RANK, -- ���ϼ��� => ���ϰ�
DENSE_RANK() OVER(ORDER BY SAL DESC) AS DENSERANK -- ���ϼ��� => �ϳ��� �Ǽ�
FROM EMP;
-- ROW_NUMBER : ������ ������ ���ؼ� ������ ���� �ο�
SELECT ENAME, SAL,
RANK() OVER(ORDER BY SAL DESC) AS ALL_RANK,
ROW_NUMBER() OVER(ORDER BY SAL DESC) AS ROW_NUM -- ����� ���� �ο�.
FROM EMP;


SELECT ENAME, SAL, SUM(SAL) OVER(PARTITION BY MGR) SUM_MGR
FROM EMP;

-- �� ���� ���� �Լ�
-- FRIST_VALUE
SELECT DEPTNO, ENAME, SAL ,FIRST_VALUE(ENAME) OVER(PARTITION BY ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) AS DEPT_A FROM EMP; 
SELECT ENAME, SAL, FIRST_VALUE(ENAME) OVER(ORDER BY SAL ASC) FROM EMP; -- MIN�� �������� �Ͱ� ���� �ǹ� (���� ���� ù���� ������)
-- LAST_VALUE
SELECT ENAME, SAL, LAST_VALUE(ENAME) OVER(ORDER BY SAL DESC) FROM EMP; -- MAX�� �������� �Ͱ� ���� �ǹ� (���� ���� �������� ������)
-- LAG
SELECT ENAME, SAL, LAG(SAL) OVER(ORDER BY SAL DESC) FROM EMP; -- ���� ���� �����´�.LAG()���� ����. => SAL
-- LEAD
SELECT ENAME, SAL, LEAD(1) OVER(ORDER BY SAL DESC) FROM EMP; 


-- PERCENT_RANK() : ��Ƽ���� JOB���� ����� �� ���� ���޵���� %�� ���Ѵ�.
SELECT ENAME, SAL, PERCENT_RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) FROM EMP; 
-- NTILE() : ()�ȿ� ���� �־��ִµ� �׿� �´� ����� �����ش�.
SELECT DEPTNO, SAL, NTILE(8) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) FROM EMP;



