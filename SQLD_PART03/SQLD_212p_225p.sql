 -- Nested Join :
 -- ���� ��ȸ�Ǵ� Table�� Outer Table / �� ������ ��ȸ�Ǵ� Table�� Inner Table��� �θ���.
 -- Outer Table�� ũ�Ⱑ �����ͺ��� ã�� ���� �߿��ϴ�. : �׷��� �����Ͱ� ��ĵ�Ǵ� ������ ���� �� ����.
 -- Random Access :
 -- Outer Table���� ROWID�� �о� �� �Ŀ� Inner Table�� �ε����� ã�µ� �� �κ��� �ǹ��Ѵ�. 

  -- use_nl�� ����� �ǵ������� Nested Join�� �� ���
  -- �ռ� �� EMP ���̺��� FULL SCAN�� �� �Ŀ� DEPT���̺��� FULL SCAN�Ͽ� Nested Join.
  -- ordered HINT :
  -- FROM���� ������ ���̺� ������� �����ϴ� ��
  -- use_nl, use_marge, use_hash�� �Բ� ���ȴ�.
 SELECT /*+ ordered use_nl */* FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
 AND E.DEPTNO = 10;
 
-- SORT MERGE JOIN

-- �ΰ��� ���̺��� SORT AREA��� �޸� ������ �ε�(Lodding)�ϰ� SORT�� ����
-- SORT�� �Ϸ�� �� ���̺��� MERGE(����)�Ѵ�.
-- SORT MERGE�� SORT�� �߻��ϱ� ������ �����;��� ������ ������ �ް��� ��������.
SELECT /*+ ordered use_merge(b)*/*
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 10;

-- HASH JOIN
-- �ΰ��� ���̺� �� ũ�Ⱑ ������ ���̺��� HASH�޸𸮿� Lodding�ϰ� �ΰ� ���̺��� ����Ű�� ����ؼ� ���̺����
-- hash�Լ��� ����ؼ� �ּҰ��, �ش� �ּҸ� ����ؼ� ���̺�����
-- CPU������ �����ϰ� �������̺��� �޸𸮿� Lodding�� ũ�⿩���Ѵ�.
SELECT /*+ ordered use_hash(b)*/* FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 10;