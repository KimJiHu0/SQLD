-- EQUI JOIN
-- ���� ��ȹ :
-- EMP, DEPT�� ��� ���� ������(TABLE ACCESS FULL)
-- �ؽ��Լ� ����ؼ� ����
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO
AND SAL > 2000;

-- INNER JOIN
SELECT * FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND SAL > 2000;

-- CROSS JOIN
-- ���ǹ��� ���� ������ EMP�� ���� ���� ���� * DEPT�� ���� ���� ������ ��ȯ
SELECT * FROM EMP, DEPT;

-- UNION(������) : �ߺ��� ���Ű� ������ ������.
-- UNION�Ϸ��� �� ���� ���̺��� �÷��� Ȥ�� ������ ������ ��ġ���� ������ ������ �߻��ϳ�.
SELECT DEPTNO FROM EMP
UNION
SELECT DEPTNO FROM DEPT;

-- UNION ALL : 
-- UNION�� �Ȱ����� �ߺ��� ����ϰ� ������ ���� �ʾ�.
SELECT DEPTNO FROM EMP
UNION ALL
SELECT DEPTNO FROM DEPT;

-- MINUS :
-- �� ���� ���̺��� �������� ������.
-- ���� ���̺��� �����ϰ� ���� ���̺��� �������� �ʴ� ���� ��ȸ.
-- DEPT�� �ִ� �ุ ��ȸ
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;


-- ������ ��ȸ
-- ���������� �����͸� ��ȸ�� �� �־�.
-- ���� -> ���� -> ���� ... �̷�������
-- �Ʒ��� Ž���ϸ鼭 ��ȸ ����, �����⵵ ����.

-- CONNECT BY : Tree���� ������ ���� �����ϴ� ��
-- START WITH : ���� ����
-- CONNECT BY PRIOR : ���� ����

-- ������ ��ȸ������ MAX(LEVEL)�� ����Ͽ� �ִ������ ���� �� �ִ�. ��, ������ Leaf NODE�� �������� ���Ѵ�.
SELECT EMPNO, ENAME, MGR, LEVEL FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;

-- ������ ��ȸ
SELECT EMPNO, ENAME, MGR, LEVEL FROM EMP
START WITH MGR IS NOT NULL
CONNECT BY PRIOR EMPNO = MGR;

SELECT LEVEL, LPAD(' ', 4 * (LEVEL-1)) || EMPNO, MGR, CONNECT_BY_ISLEAF
FROM EMP START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;



-- SUBQUERY
-- SELECT���� SUBQUERY�� ����ϴ� ���� SUBQUERY��� �Ѵ�.
-- () �ۿ� �ִ� SELECT���� MAIN QUERY�̴�.
SELECT * FROM EMP WHERE DEPTNO =
(SELECT DEPTNO FROM DEPT WHERE DEPTNO = 10);

-- INLINE VIEW
-- FROM���� SUBQUERY�� �ۼ��ϴ� ���� INLINE VIEW��� �Ѵ�.
SELECT ROWNUM, EMPNO, ENAME, SAL FROM
(SELECT * FROM EMP ORDER BY SAL DESC) A;


-- ������ �������� / ������ ��������

-- ������ �������� : ��������� ��ȯ�Ǵ� ���� ������ �Ѱ��� �� [�񱳿����� : >,<,>=, <=, <>]
-- ������ �������� : ��������� ���ѵǴ� ���� ������ �������� �� [�񱳿����� : IN,ALL,ANY,EXISTS]

-- ������ �������� : 

-- IN
-- IN�� ��ȯ�Ǵ� ������ ���߿��� �ϳ��� ���̵Ǿ ���� ����ȴ�.
-- ������ ���������̱� ������ SAL�� 2000�ʰ��� �ֵ��� EMPNO�� �ϴ� �����Դµ�
-- EMP�� DEPT�� ������ �ֵ� �߿��� ���������� ������� �´°͵� ���
SELECT ENAME, DNAME, SAL FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
AND EMP.EMPNO IN (SELECT EMPNO FROM EMP WHERE SAL > 2000);

-- ALL
-- ALL�� ���� �ΰ� ���� �����ؾ� ��.
-- �Ʒ��� ���, 20��,30 ���� �۰ų� �����ֵ� ���
-- 10,20 �ۿ� ���� ������ DEPTNO�� 10,20 �� �ֵ鸸 ���
SELECT * FROM EMP WHERE DEPTNO  <= ALL(20,30);

-- EXISTS
-- ���������� � ����Ʈ ���� ���θ� Ȯ��
-- SUBQUERY : EMP���̺� SAL�� 2000�ʰ� �� �ֵ��� ������ TRUE
SELECT ENAME, DNAME, SAL FROM EMP JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO
AND EXISTS (SELECT 1 FROM EMP WHERE SAL > 2000);


-- ��Į�� SUBQUERY
-- ���������� ������� �� ��, �� �÷��� �����ϴ� ��������.
-- ��� SELECT���� SUBQUERY�� �ۼ��Ѵ�.
-- ��Į�� SUBQUERY�� ������� ���� ���̸� ����.
SELECT
ENAME AS "�̸�",
SAL AS "����",
(SELECT AVG(SAL) FROM EMP) AS "��ձ޿�"
FROM EMP
WHERE ENAME = 'KING';

-- ���� SUBQUERY
-- �������� ������ ���������� �÷��� ����ϴ� ��
SELECT * FROM EMP E
WHERE E.DEPTNO = (SELECT DEPTNO FROM DEPT D
WHERE E.DEPTNO = D.DEPTNO);


-- ROLLUP
SELECT 
DECODE(DEPTNO, NULL, '��ü�հ�', DEPTNO) AS "�μ���ȣ",
SUM(SAL) AS "�μ����հ�"
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

-- [ �������Լ�  ] 
-- ��� �� ���� ���踦 �����ϱ� ���ؼ� �����Ǵ� �Լ�
-- ���, �հ�, ���, �� ��ġ�� ���� �� �� �ִ�.


-- WINDOWING�Լ� : ��������
-- EMPNO, ENAME, SAL, SUM(SAL)�� ��ȸ�Ұǵ�
-- OVER�� SAL�� ORDER BY���� ��
-- ROWS�� �������ٰǵ�
-- BETWEEN ? AND ? : ?���� ?����
-- UNBOUNDED PRECEDING : ù��° �����
-- UNBOUNDED FOLLOWING : �����������
SELECT
EMPNO,
ENAME,
SAL,
SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "�հ�" FROM EMP;


-- CURRENT ROW : ���� �� ��ġ���� => �����Ͱ� ����� ���� ��
-- ��������� �����հ踦 �����Ѵ�.
SELECT
EMPNO,
ENAME,
SAL,
SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TOTAL
FROM EMP;

-- [�����Լ�]
-- RANK, DENSE_RANK, ROW_NUMBER

-- RANK : ������ ������ ������ ������ �ο��ǰ�, ������ ������ �ϳ��� �Ǽ��� ġ�� �ʴ´�.��, ���� �ϳ��� ������ �ο��Ǵ� �� [ 1,2,2,3 ���� �ִٸ�  ] => [ 1,2,2,4 ]�� �ȴ�.
-- DENSE_RANK : ������ ������ ������ ������ �ο��ǰ�, ������ ������ �ϳ��� �Ǽ��� ģ��. ��, ���� �ϳ��� ������ �ο��Ǹ鼭 1,2,2,3 ���̸� �״�� ���ٴ� �ǹ�.
-- ROW_NUMBER : ������ ������ ���ؼ� ������ ������ �ο��Ѵ�. �ߺ��� �����ʰ� ������� �ο��Ѵ�. 

-- RANK()�Լ� ����ϱ� : 2���� 2���ε� �̴� �ϳ��� �Ǽ��� ġ�� �ʴ´�.
SELECT EMPNO, ENAME, SAL, RANK() OVER(ORDER BY SAL DESC) AS "�޿�����" FROM EMP;

-- DENSC_RANK() : 2���� 2���ε� �ϳ��� �Ǽ��� ģ��.
SELECT EMPNO, ENAME, SAL, DENSE_RANK() OVER(ORDER BY SAL DESC) AS "�޿�����" FROM EMP;

-- ROW_NUMBER : ���� �ߺ��Ǵ� ���� ������ ��ȣ�� ������� �ο��Ѵ�.
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY SAL DESC) AS "������ȣ" FROM EMP;


-- [ �����Լ� ]

-- AVG() : ���
SELECT AVG(SAL) FROM EMP;
-- SUM() : �հ�
SELECT SUM(SAL) FROM EMP;
-- COUNT() : NULL���� ������ ��� ����
-- COUNT(�÷���) : NULL���� ������ ����
SELECT COUNT(*) FROM EMP;
SELECT COUNT(COMM) FROM EMP;
-- MAX() / MIN() : �ִ밪, �ּҰ�
SELECT MAX(SAL), MIN(SAL) FROM EMP;


-- [�� ���� ���� �Լ�]

-- FIRST_VALUE : ���� ó���� ������ �� <MIN�Լ��� ������ ���>
-- LAST_VALUE : ���� �������� ������ ��<MAX�Լ��� ������ ���>
-- LAG : ���� ���� ������ ��.
-- LEAD : Ư�� ��ġ�� ���� ������ ��.

-- OVER(PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) AS DEPT_A : DEPT_A ��� ��Ƽ���� ���� ������µ� SAL�� DESC ���� ���¿���
-- UNBOUNDED PRECEDING : ���� ù���� ���� �����´�. �ᱹ SAL�� ���� ū ����� ���� �����س���.
-- FIRST_VALUE : �μ� ������ ���� ������ ���� ����� ENAME�� ���
SELECT DEPTNO, ENAME, SAL, FIRST_VALUE(ENAME) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) AS DEPT_A FROM EMP;

-- ���� ����� �ݴ�� �����ں��� ����������� ����, SAL�� DESC�δ�� DEPTNO��� ��Ƽ���� ���� �̸��� DEPT_A
-- LAST_VALUE : ���� �������� �ִ� ���� ������.�ٵ� DESC�� ����� ������ ���� ���������ִ¾ְ� ���� ���ڰ� ������
SELECT DEPTNO, ENAME, SAL,
LAST_VALUE(ENAME) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING ) AS DEPT_A
FROM EMP;

-- LAG() : �̰� ���� �������� ��.
-- SAL�� ������, ó�� �������� NULL�̰�, �ι��� PRE_SAL���� ���� SAL�� ���� 5000�� �����´�.
SELECT DEPTNO, ENAME, SAL,LAG(SAL) OVER(ORDER BY SAL DESC) AS PRE_SAL FROM EMP;

-- LEAD() : Ư���� ���� �����´�.
-- SAL�÷��� �� �߿� 2���� �ָ� �����´�.
SELECT DEPTNO, ENAME, SAL, LEAD(SAL, 2) OVER(ORDER BY SAL DESC) FROM EMP;


-- [ ���� ���� �Լ� ]
-- ���� ����� , ������ �����, ��Ƽ���� N������ ������ ��� ��
-- CUME_DIST : ��Ƽ�� ��ü�Ǽ����� �����ຸ�� �۰ų� ���� �Ǽ��� ���� ���� ����� ��ȸ
-- PERCENT_RANK : ��Ƽ�ǿ��� ���� ���� ���� ���� 0 , ���� �ʰ� ���°� 1�� �Ͽ� ���� �ƴ� ���� ������ ����� ��ȸ
-- NTILE : ��Ƽ�Ǻ��� ��ü�Ǽ��� ARGUMENT������ N����� ��� ��ȸ
-- RATIO_TO_REPORT : ��Ƽ�� ���� SUM�� ���� �� �� Į������ ��п��� �Ҽ������� ��ȸ

-- PRECENT_RANK()
SELECT DEPTNO, ENAME, SAL, PERCENT_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS PERCENTRANK

-- NTILE() : �޿��� ���� ������ 4���
SELECT DEPTNO, ENAME, SAL, NTILE(4) OVER(ORDER BY SAL DESC) AS N_TILE
FROM EMP;


-- [ PARTITION ��� ]
-- ��뷮 ���̺��� �������� ������ ���Ͽ� �и��ؼ� ����.
-- �����Ͱ� ���������� �и��� ������ ���Ͽ� ����Ǹ� �Է�,����,����,��ȸ ���� ���
-- PARTITION�� ���� �������̴�.��, PARTITION���� ����ϰ� ���� ����, ���� INDEX��������
-- ������ ��ȸ �� ������ �ٿ��� �������

-- RANGE PARTITION
-- �÷� �߿��� ���� ������ �������� ���� ��Ƽ������ ������ ������ ����.
-- ������, SAL�� 2000�̻��� �ֵ��� PARTITION01�� ����, �������� PARTITION02�� ����

-- LIST PARTITION
-- Ư�� ���� ������ ����
-- ������, DEPTNO�� 10���ξֵ��� PARTITION01 / DEPTNO�� 20���ξֵ��� PARTITION02�� ����

-- HASH PARTITION
-- ���������� HASH�Լ��� ����ؼ� ������ ����


-- [ PARTITION INDEX ]
-- GLOBAL INDEX : �������� ��Ƽ�ǿ��� �ϳ��� �ε����� �����
-- LOCAL INDEX : �ش� ��Ƽ�� ���� ������ �ε����� �����
-- PREFIXED INDEX : ��Ƽ�� Ű�� �ε��� Ű�� ������
-- NON PREFIXED INDEX : ��Ƽ�� Ű�� �ε��� Ű�� �������� �ʾ�