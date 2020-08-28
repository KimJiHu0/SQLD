-- SQLD part03 148p ~ 170p


-- �����Լ�

-- ���������
SELECT MOD(7,4) FROM DUAL;
-- ���밪
SELECT ABS(-1000) FROM DUAL;
-- ����, 0 ,��� �פ̺�
SELECT SIGN(0) FROM DUAL;
-- ������ ���ں��� ũ�ų� ���� �ּ� ����
SELECT CEIL(10.8) FROM DUAL;
-- ������ ���ں��� �۰ų� ���� �ִ� ����
SELECT FLOOR(10.3) FROM DUAL;
-- ������ �Ҽ����ڸ����� �ݿø�
SELECT ROUND(10.345, 2) FROM DUAL;
-- ������ �Ҽ��� �ڸ����� ����
SELECT TRUNC(10.345, 2) FROM DUAL;



SELECT * FROM EMP;
-- DECODE : EMPNO�� 7499�ΰ� ���̸� '��'���, �����̸� '����'���
SELECT DECODE(EMPNO, '7499', '��', '����') FROM EMP;

-- CASE : 
-- CASE WHEN : SAL�� 1000 �̸��� ��
-- THEN : '�ϱ�' ���
-- ELSE : �װ� �ƴҶ� '���' ���
-- END : CASE�� ����
SELECT CASE WHEN SAL < 1000 THEN '�ϱ�' ELSE '���' END FROM EMP;


-- ROWNUM : ������ ���� ��ȣ
-- �������� �� �ȿ��ִ� SAL�� DESC�� �������� �Ŀ�
-- ������������ ROWNUM�� ����Ѵ�.
-- ROWNUM�� �� �� Ȥ�� 5 �̸��� �� �̷������� ������ �� ������
-- �߰��� �ִ� ���� ������ �� ����.
-- �׷��� ���ؼ� 
SELECT ROWNUM, ENAME, SAL FROM (SELECT * FROM EMP ORDER BY SAL DESC) A;
SELECT ROWNUM, ENAME, SAL FROM EMP WHERE ROWNUM < 5;


-- ROWID : �����͸� ������ �� �ִ� ������ ���� ������ȣ?
SELECT ROWID FROM EMP;

-- WITH : ���������� ����ؼ� �ӽ� TABLE�̳� VIEW�� �����.
WITH W_EMP AS
(SELECT * FROM EMP WHERE DEPTNO = 30)
SELECT * FROM W_EMP;



-- DCL (������ ����)
-- GRANT : 
-- �ο� ������ ����
-- SELECT : ��ȸ
-- INSERT : �Է�
-- UPDATE : ����
-- DELETE : ����
-- REFERENCES : �������� ����
-- ALTER : ���̺� ����
-- INDEX : INDEX����
-- ALL : ���� ��

-- GRANT�� ������ �ο��Ұǵ� , ��ȸ, �Է�, ����, ������ �ο�
-- ON EMP : EMP���̺� ���ؼ�.
-- TO TEST1 : TEST1�̶�� ����ڿ���.
GRANT SELECT, INSERT, UPDATE, DELETE ON EMP TO TEST1;

-- EMP���̺� ���� ��ȸ, �Է�, ����, ���� ������ TEST1�̶�� ����ڿ��� �ش�.
-- WITH GRANT OPTION :
-- A��� ����ڰ� B��� ����ڿ��� ������ �ο��� ������ ���. �׸��� B��� ����ڰ� C��� ����ڿ��� ������ �ο��ߴ�.
-- �� �� A��� ����ڰ� B��� ������� ������ REVOKE(���)�Ѵٸ� ����� B�� C�� ���� ���.
GRANT SELECT, INSERT, UPDATE, DELETE ON EMP TO TEST1 WITH GRANT OPTION;

-- EMP���̺� ���� ��ȸ, �Է�, ����, ������ TEST1�̶�� ����ڿ��� ���� �ο�.
-- WITH ADMIN OPTION : 
-- A��� ����ڰ� B��� ����ڿ��� �Ʒ��� ���� ������ �ο��ߴ�.
-- B��� ����ڴ� C��� ����ڿ��� ������ �ο��ߴ�.
-- �� �� A��� ����ڰ� B��� ����ڿ� ���� ������ REVOKE(���)���� ��
-- C��� ������� ������ ������ �ȴ�.
GRANT SELECT, INSERT, UPDATE, DELETE ON EMP TO TEST1 WITH ADMIN OPTION;