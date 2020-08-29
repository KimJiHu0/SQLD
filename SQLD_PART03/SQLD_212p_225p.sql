-- 옵티마이저(Optimizer)
-- SQL을 실행할 때 어떻게 실행할 것인지 계획을 세운다.
-- 실행계획(Executuon plan)을 수립하고 SQL을 실행한다.
-- 실행계획을 수립하고 SQL실행하는 스프트웨어

-- 옵티마이저 특징
-- 데이터 딕셔너리(DATA DICTIONARY)에 있는 오브젝트 통계, 시스템통계 정보를 사용헤서 예상되는 비용을 산정
-- 실행계획 중 최저비용을 가지고 있는 계획을 선택해서 실행

-- 옵티마이저의 필요성
-- 데이터가 큰 테이블을 먼저 조회하고 다음 테이블을 조회하고 동일한 행을 찾으면 불필요한 조회 횟수가 증가하여 성능이 떨어진다.
-- 실행계획을 수립하고 최저비용으로 SQL을 실행할 수 있도록 해준다.
-- 실행계획을 변경하도록 요청할 수 있는데 이를 HINT라고 한다.

-- 옵티마이저 실행계획 확인
-- 옵티마이저는 SQL실행계획을 PLAN_TABLE에 저장한다.
-- DESC PLAN_TABLE를 CMD에 쳐보면 볼 수 있다.

-- 옵티마이저 실행 방법
-- 개발자가 SQL을 실행하면 PARSING을 실행해서 SQL문법 검사 및 구문분석 수행
-- 구문분석이 완료되면 규칙기반, 비용기반으로 실행계획 수립
-- 기본적으로 비용기반으로 실행계획 수립
-- 비용기반 : 최저비용으로 최적의 실행계획을 수립
-- 규칙기반 : 15개의 우선순위를 토대로 수립


-- INDEX
-- 데이터를 빠르게 검색할 수 있는 방법
-- 인덱스는 인덱스키로 정렬되어있기 때문에 원하는 데이터를 빠르게 조회
-- 인덱스는 오름차순 / 내림차순으로 탐색 가능
-- 하나의 테이블에 여러 INDEX 생성가능, 하나의 인덱스는 여러개 컬럼으로 구성될 수 있음
-- 테이블 생성시 기본키는 자동으로 인덱스가 만들어지고 이름은 SYSXXXX

-- INDEX 생성
-- INDEX의 이름은 IND이고 EMP테이블에서 ENAME은 오름차순, SAL은 내림차순으로 만들거야.
-- 데이터를 빠르게 검색할 수 있는 방법!!!!
CREATE INDEX IND ON EMP(ENAME ASC, SAL DESC);

-- INDEX SCAN --

-- 1.UNIQUE INDEX SCAN
--	인덱스 KEY값이 중복되지 않는 경우
--	EX ] EMPNO가 중복되지 않는 경우 특정 하나 EMPNO 조회

-- 2. INDEX RANGE SCAN
--	SELECT문에서 특정 범위를 조회하는 WHERE문을 사용 할 경우
--	LIKE, BETWEEN이 대표적. 데이터 양이 적으면 인덱스 자체 실행하지 않고 TABLE FULL SCAN 실행

-- 3. INDEX FULL SCAN
--	검색되는 데이터의 양이 많은 경우에 실행
--	인덱스를 모두 읽는것

-- [ 옵티마이저 조인 ]
-- 1. Nested Join
--	하나의 테이블에서 데이터를 찾고, 다음 테이블을 조인하는 방식
--	먼저 조회되는 테이블 : 외부테이블 OUTER TABLE
--	그 다음에 조회되는 테이블 : 내부테이블 INNER TABLE
--	외부테이블(선행테이블)의 크기가 작은 것을 찾는것이 중요. 그래야 데이터 스캔범위를 줄일 수 있음
--	RANDOM ACCESS : 테이블의 INDEX를 찾을 때 발생하는 현상
--	RANDOM ACCESS가 많이 발생하면 성능 지연

-- 2. SORT MERGE JOIN
--	두 개의 테이블을 모두 SORT AREA에 LODDING하고 SORT를 수행.
--	두 개의 테이블의 SORT가 완료되면 MERGE.
--	SORT MERGE JOIN은 정렬이 발생하기 때문에 데이터 양이 많아지면 성능저하

-- 3. HASH JOIN
--	두 개의 테이블 중 크기가 작은 테이블을 HASH메모리에 LODDING하고
--	두 개의 테이블의 조인키를 이용해서 해시 테이블을 생성
--	HASH함수는 주소를 계산하고 주소를 사용해서 조인하기떄문에 CPU연산 많이 사용
--	HASH조인 시 선행테이블이 메모리에 LODDING되는 크기어야함.


-- NESTED JOIN 과 HASH JOIN의 차이점
--	NESTED JOIN : 데이터의 INDEX를 찾는다.
--	HASG JOIN : 데이터의 주소를 찾는다.



