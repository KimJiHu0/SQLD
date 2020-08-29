-- 229P [�� ����]

-- 3�� : ���̺� �����ϱ�
CREATE TABLE LIMBEST(
	ID VARCHAR2(10) PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL,
	AGE NUMBER(3) DEFAULT 1,
);
-- 5�� : FK�� �̿��ؼ� ���̺� �����ϱ�
CREATE TABLE ����(
	NAME VARCHAR2(10),
	AGE VARCHAR2(10),
	�ξ��� NUMBER,
	CONSTRAINT NAME_PK PRIMARY KEY(NAME),
	CONSTRAINT �ξ���_FK FOREIGN KEY(�ξ���) REFERENCES ���(���)
);
--8�� : INDEX �����ϱ�
CREATE INDEX idx_mgr ON EMP(MRG);
-- 14�� : MGR �÷����� NULL�̸� 9999���
SELECT NVL(MGR, '9999') FROM EMP;
-- 18�� : ��¥�����͸� ���ڷιٲٰ� ���ڿ��� ������ ���
SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL;
-- 23�� : SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO��   ANSI/ISOǥ�� SQL������ ����
SELECT * FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 10;
-- 25�� : EMP, DEPT���̺� �÷��� ���� ����ϱ�
SELECT * FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO (+)= D.DEPTNO;
SELECT * FROM EMP RIGHT OUTER JOIN DEPT 
ON EMP.DEPTNO = DEPT.DEPTNO;

---------------------------------------

--���������ϱ�
--5��
CREATE TABLE ����(
	�̸� VARCHAR2(20),
	�ξ��� VARCHAR2(20),
	���� NUMBER DEFAULT 1,
	CONSTRAINT �̸�_PK PRIMARY KEY(�̸�),
	CONSTRAINT �ξ���_FK FOREIGN KEY (�ξ���) REFERENCES ���(�ξ���)
);
-- 8��
CREATE INDEX idx_mgr ON EMP(MGR);

-- 11��
-- TRUNCATE TABLE�� ���� �������� �ùٸ��� �ʴ� ����? 2
-- 1. WHERE�� ������ �� ����.
-- 2. �ܷ�Ű ���ȼ��� Ȯ���Ѵ�.
-- 3. ROLLBACK�� �� �� ����.
-- 4. �ڵ����� COMMIT�Ѵ�.
-- [�ؼ�]
-- WHERE���� ������ �� ����, ROLLBACK�� �� �� ����, �ڵ����� COMMIT�ȴ�.
-- TRUNCATE TABLE�� �ܷ��� ���Ἲ�� Ȯ������ �ʰ�
-- TABLE�� ���ؼ� LOCK�� ȹ�� �� �ϰ������� ������ �����Ѵ�.
-- ��, TRUNCATE TABLE�� ������ �ǽ��ϸ� ���̺� �뷮�� �ʱ�ȸ�ȴ�.

-- 12��
-- SELECT 20 + 10, 20 + NULL, NULL + 20 FROM DUAL; �� �����?
-- ��� : 30,NULL,NULL
-- �ؼ� : ���ڿ� NULL�� �����ϰ� �Ǹ� NULL�� ��ȯ�ȴ�.

-- 20��
-- SELECT 1 FROM DUAL UNION SELECT FROM 2 FROM DUAL UNION SELECT 1 FROM DUAL; ��������? 1
-- 1. 1,2
-- 2. 1,2,1
-- 3. 2,1
-- 4. 1
-- [�ؼ�]
-- UNION�� �������� �����. 1��2��1�� ���ؼ� ������ִµ� �� �� �ߺ��� �����ϰ� SORT�� �����Ѵ�.

-- 22��
-- ǥ�� ������ �����ϴ� �����Լ��� ? 3
-- 1. AVG() 2. SUM() 3. STDDEV() 4. VARIAN()
-- [�ؼ�]
-- AVG() : ��� / SUM() : �ջ� / VARIAN() : �л��� ���

-- 26��
-- SELECT ROUND(10.51234,1) FROM DUAL; �� ��������? 2
-- 1. 10 2. 10.5 3. 10.51 4. 11
--[�ؼ�]
-- ROUND�� ���ִµ� �Ҽ��� ù°�ڸ����� �ش޶�� �����ϱ� 10.5

-- 28��
-- CONNECT BY�� ���� �������� �ùٸ��� �ʴ°���? 1
-- 1. CONNECT_BY_ISLEAF�� ������������ Leaf �����͸� 0, �ƴϸ� 1�� ������.
-- 2. CONNECT_BY_ISCYCLE�� Root������ ��ο� �����ϴ� �����͸� �ǹ��Ѵ�.
-- 3. CONNECT_BY_ROOT�� Root ����� ������ ǥ���Ѵ�.
-- 4. SYS_CONNECT_BY_PATH�� ���� ������ Į������ ��� ǥ���Ѵ�.
--[�ؼ�]
-- CONNECT_BY_ISLEAF�� ������������ Leaf �����߸� 1, �ƴϸ� 0�� ������.

-- 30��
-- SELECT * FROM EMP WHERE EMPNO LIKE '100%'; �� ����� �ùٸ��� �ʴ°���?(EMPNO�� �⺻Ű, ����) 1
-- 1. EMP ���̺��� FULL SCAN�� ���� �ε����� �����.
-- 2. ���������� ����ȯ�� �߻��ߴ�.
-- 3. LIKE������ ����������� ">"������ ����ؾ��Ѵ�.
-- 4. ��ɻ����δ� ������ ������ , �������� ������ �ִ�.
--[�ؼ�]
-- EMPNO�� �⺻Ű�� �ڵ����� �ε����� �����ȴ�. �׷��� FULL SCAN�� �� ������ LIKE���ǿ���  ���� Į���� ������ ���� ����ȯ�� �߻��ؼ���.