-- SQLD part03 106p~147p

-- DBMS
-- ������ �����ͺ��̽� : Tree���� �ڷᱸ���� �����͸� ����/����
-- ��Ʈ��ũ�� �����ͺ��̽� : owner / member���·� ������ ����
-- ������ �����ͺ��̽� : �����̼ǿ� DATA ����/����/���տ���/���迬��/1��N����ǥ��
-- Oracle, MySQL, MSSQL, Sybase ���

-- <������ �����ͺ��̽�(RDBMS)>
-- [���տ���]
--	������(Union) : �� ���� �����̼��� �ϳ��� ���ļ� �ߺ��� ��(Ʃ��)�� �ѹ��� ��ȸ
--	������(Difference) : ���� �����̼ǿ� �����ϰ� �ٸ� �����̼ǿ� �������� �ʴ� ���� ��ȸ
--	������(Intersection) : �� ���� �����̼� ���� ����� ���� ��ȸ
--	������(Cartesian product) : �� �����̼ǿ� �����ϴ� ��� �����͸� �����Ͽ� ����

-- [���迬��]
--	���ÿ���(Selection) : �����̼ǿ� ���ǿ� �´� ��(Ʃ��)�� ��ȸ
--	��������(Projection) : �����̼ǿ� ���ǿ� �´� �ӻ� ��ȸ
--	���տ���(Join) :���� �����̼��� ����� �Ӽ��� ����ؼ� ���ο� �����̼��� ����
--	�����⿬��(Division) : ���� �����̼ǿ��� ������ �����̼��� ������ �ִ� �Ӽ��� ������ ���� ������ ���� ����, ������ �����̼��� �Ӽ��� ������ �� �ߺ� �� ����

-- <���̺� ����>
-- �⺻Ű�� ������ �ִ�.
-- ��� �÷����� �̷���� �ִ�.
-- �÷��� �ʵ�� �Ӽ��̶�� �Ѵ�.
-- �ܷ�Ű�� �ٸ� ���̺��� �⺻Ű�� �����Ѵ�.
-- �ܷ�Ű�� ���迬�� �� ���տ���(����)�� �ϱ� ���� ���ȴ�.

-- < SQL(Structured Query Language) >
--	�����ͱ����� ����, ����, ������ �� �ִ� ������ ���
--	ANSI/ISO ǥ�� : INNER JOIN, NATUAL JOIN, USING ����, ON ������ ���

-- SQL����
--	DDL : ������ ���� / CREATE, ALTERT, DROP, RENAME 
--	DML : ������ ���� / INSERT, UPDATE, DELETE, SELECT
--	DCL : ������ ���� / GRANTE, REVOKE
--	TCL : Ʈ����� ���� / COMMIT / ROLLBACK
-- ������� : �Ľ� => ���� => ����

-- <Ʈ������� Ư¡>
--	���ڼ� : DB������ ��� ���� OR ��� �̽��� / Ʈ����� ó���� ������ ������ ������� ���� ó���� ���ƾ���. 
--	�ϰ��� : Ʈ����� ���� ����� DB���°� ��������ʾƾ���. / Ʈ����� ���� �Ŀ��� �ϰ��� �ְ� ����
--	���� : Ʈ����� ���� �߿� �ٸ� Ʈ������� ���� �Ұ�
--	���Ӽ� : Ʈ����� ���� �� ������ ���� 

--<CRUD>--

-- ���̺�� ����
ALTER TABLE EMP RENAME TO NEW_EMP;
ALTER TABLE NEW_EMP RENAME TO EMP;
-- �÷� �߰�
ALTER TABLE EMP ADD(AGE VARCHAR2(20));
-- �÷��� ����
ALTER TABLE EMP RENAME COLUMN AGE TO AGE1;
-- �÷� Ÿ�� , ����, �������� ����
ALTER TABLE EMP MODIFY(AGE VARCHAR2(10));
-- �÷� ����
ALTER TABLE EMP DROP COLUMN AGE;

-- ���̺� �����
CREATE TABLE TEST(
	NAME VARCHAR2(10) NOT NULL,
	AGE NUMBER UNIQUE,
	ADDR VARCHAR2(10)
);
-- Ư�� �÷��� ���ֱ�
INSERT INTO TEST(NAME, AGE)
VALUES('JIHU', 10);

-- INSERT�ϱ�
INSERT INTO TEST VALUES('JIHU1', 20, 'INCHEON');

-- Ư�� �÷� ��ȸ
SELECT * FROM TEST WHERE NAME = 'JIHU';

-- ��ü �÷� ��ȸ
SELECT * FROM TEST;

-- ���̺� �뷮���� ����
TRUNCATE TABLE TEST;
DROP TABLE TEST;


-- ORDER BY : ���� / DESC : �������� / ACS : ��������
SELECT EMPNO FROM EMP ORDER BY EMPNO DESC;

-- DISTINCT : �ߺ��� �� �����ϰ� ��ȸ�ϱ�
SELECT DEPTNO FROM EMP;
SELECT DISTINCT DEPTNO FROM EMP;

-- NVL�Լ� SELECT
SELECT NVL(COMM, 0) FROM EMP;
SELECT NVL2(COMM, 1, 0) FROM EMP;
SELECT NULLIF(300, 300) FROM EMP;
SELECT COALESCE(NULL, 2,4) FROM EMP;

-- �����Լ� ����ϱ�
SELECT JOB, AVG(SAL) FROM EMP
GROUP BY JOB;


-- < ������ >
-- ���� �ʴ� ���� ��ȸ : !=, ^=, <>, NOT �÷���, 
-- ũ�� ���� ���� ��ȸ : NOT �÷��� >

-- ��������
--	AND : ������ ��� �����ؾ� TRUE
--	OR : ���� �� �ϳ��� �¾Ƶ� TRUE
--	NOT : ���̸� ��������, �����̸� ������

-- SQL������
--	LIKE %�񱳹��ڿ�% : �񱳹��ڿ��� ���ԵȰ� ���
--	BETWEEN A AND B : A�� B ����
--	IN : OR�� �ǹ��ϰ� list�� �� �ϳ��� ��ġ�ص� ��ȸ��
--	IS NULL : NULL�� ��ȸ

-- ����SQL������
--	NOT BETWEEN A AND B : A�� B���̰� �ƴѾֵ� ��ȸ
--	NOT IN : list�� ����ġ�� �� ��ȸ
--	IS NOT NULL : NULL���� �ƴѾֵ� ��ȸ

-- S�� �����ϴ� ENAME ��ȸ. LIKE ���
SELECT ENAME FROM EMP WHERE ENAME LIKE 'S%';
-- S�� ������ ENAME ��ȸ. LIKE ���
SELECT ENAME FROM EMP WHERE ENAME LIKE '%S';
-- S�� ȣ�ʵǴ� ENAME ��ȸ. LIKE ���
SELECT ENAME FROM EMP WHERE ENAME LIKE '%S%';

-- TEST_ NAME�� TEST �İ� �ڿ� �ѱ��� �� ���� �� ��ȸ�ϱ�
SELECT NAME FROM TEST WHERE NAME LIKE 'JIHU_';

-- IN�� �̿��ؼ� ��ȸ / JOB CLERK, MANAGER �� �ֵ� ���
SELECT * FROM EMP WHERE JOB IN ('CLERK', 'MANAGER');
-- �ΰ��� �÷��� ���ÿ� ��ȸ
SELECT * FROM EMP WHERE (JOB, ENAME) IN (('CLERK', 'SMITH'), ('MANAGER', 'JONES'));

-- NULL ��ȸ
-- �𸣴� ���� �ǹ�
-- ���� ���縦 �ǹ�
-- ���� Ȥ�� ��¥�� ���ϸ� NULL
-- � ���� ���� �� �˼����� ��ȯ
-- NULL ��ȸ : IS NULL / NULL�ƴ� �� ��ȸ : IS NOT NULL


-- �����Լ�
-- COUNT() : ���� ����
-- SUM() : �հ�
-- AVG() : ���
-- MAX() / MIN() : �ִ� / �ּ�
-- STDDEV() : ǥ������
-- VARIAN() : �л���

-- COUNT(*) / COUNT(�÷���)
-- 4�� ��� (NULL�� ����)
SELECT COUNT(COMM) FROM EMP;
-- 14�� ���(NULL�� ����)
SELECT COUNT(*) FROM EMP;

-- SELECT ���� ����
-- FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY

-- ����ȯ
-- TO_NUMBER : ���ڿ��� ���ڷ� ��ȯ
-- TO_CHAR : ���� Ȥ�� ��¥�� ������ FORMAT�� ���ڷ� ��ȯ
-- TO_DATE : ���ڿ��� ������ FORMAT�� ��¥������ ��ȯ