-- GDB 설명
-- =================
-- GDB는 node와 edge로 표현되는 graph 모델을 이용해 데이터를 표현하고 저장하는 데이터베이스입니다.
-- 이를 통해 현실세계에 존재하는 다양한 데이터와 데이터들의 관계를 모두 표현할 수 있는데요,
-- 최근 빅데이터로 통칭되는 모든 유형의 비즈니스 데이터를 저장하고 처리할 수 있는
-- newSQL 데이터베이스의 한 종류가 GDB입니다.


-- GDB와 RDB의 모델링 차이점 설명
-- =================
-- GDB는 원하는 관계들을 노드와 에지로 구성된 그래프 패턴으로 정의해 자유롭게 질의할 수 있습니다. 
-- RDB는 (불가능하다는 것은 아니지만) 이미 구축된 스키마에 대해서만 질의가 용이하다는 차이가 있습니다.

-- 조금 더 부연 설명을 하자면,
-- RDB에서는 데이터의 관계가 entity라는 테이블로 묶여있고, 
-- join 구문 통해 여러 테이블을 중첩해서 연결된 관계를 질의합니다.
-- 이 과정에서 쿼리는 매우 복잡해지며 join을 위한 계산 비용도 커집니다.

-- 그에 반해, GDB는 데이터의 관계가 graph로 간결하게 표현되고 성능 또한 관계 질의에 최적화 되어 있습니다. 
-- 이 때 사용되는 Cypher 라는 그래프 질의언어는 graph 패턴을 동일한 문법으로 손쉽게 접근할 수 있도록 도와줍니다.

-- 메타쿼리 설명
-- =================
-- GDB는 프리 스키마이기 때문에 모델이 중요하고, 수많은 관계가 표현되는 만큼 
-- 관찰하고자 하는 데이터의 범위를 그래프 패턴으로 정의해야 합니다.

-- 질의와 더불어서 원하는 결과를 얻기 위해서도 그래프 패턴을 정의합니다.
-- 예를 들어, 고객의 구매 데이터를 통해 고객이 선호하는 제품을 보고자 한다면
-- 고객과 상품간의 선호 관계를 정의해서 질의하면 됩니다.

-- 이 과정을 본 동영상에서 시연을 통해 설명해 드리겠습니다.


-- 일단 쿼리해 보기 : 고객, 주문, 상품
match path=(c:customer)-[:purchased]->(o:"order")-[r:orders]->(p:product) 
return path
limit 100;

-- 0) 전체 구성 요소 설명 : 쿼리창, 그래프결과창 (라벨 리스트), 테이블결과창, 상세보기
--      라벨리스트 : 노드와 에지 설명 (아이콘 구별)
-- 1) 보기 편하게 스타일 적용 (고객은 크게, 주문은 작게)
-- 2) 라벨별로 좌우로 분리 --> 보기 어려움
-- 3) 레이아웃 설명
-- 4) COSE2 적용 
-- 5) findNeighbors 토글 적용 ==> 서브 그래프 단위로 살펴야 관찰이 쉬움을 설명
-- 6) 네이버와 상품을 선택 후, hide unselect 후 dagre 레이아웃 적용
--    ==> 선택 내용만 이미지 익스포트

-- 7) ANTON 의 구매 그래프 조회
-- 7-1) Dagre 레이아웃
-- 7-2) order에 대한 확장 ==> 판매사원 조회 (4명)
match path=(c:customer)-[:PURCHASED]->(o:"order")-[:ORDERS]->(p:product)-[:PART_OF]->(:category)
WHERE c.ID = 'ANTON' 
return path
limit 100;


-- 8) 디테일하게 살펴보기
-- 8-1) 간단한 통계 쿼리 작성

-- 고객의 구매 횟수 조회
-- : order_cnt 가 customer에 없기 때문에 질의

match (c:customer)-[:purchased]->(o:"order")
return c.id, c.name, count(o) as order_cnt
order by order_cnt desc 
limit 10;

/*
-- 고객의 구매 총수량 조회
--> rated 에지 생성
match (c:customer)-[:purchased]->(o:"order")-[r]->(p:product) 
return c, p, count(o) as order_cnt, sum(r.quantity::int) as quantity
order by order_cnt desc 
limit 10;

-- rated 그래프 출력
-- 너무 많으니 간선을 제거 : order_count >= 3 이상
match path = (c:customer)-[r]->(p:product) 
where (r.order_count::int) > 3
return path
limit 100;

-- 중심 노드에 customer.id='SAVEA' 선택  
-- 너무 많아서 order_count > 3 으로 제한 
match path = (c:customer)-[]->(o:"order")-[]-(p:product)-[]->(t:category)
			, (c)-[r:rated]->(p)
where c.id='SAVEA' and r.order_count::int > 3
return path
limit 100;

-- 그래프 한번에 보기 (라벨 클릭으로 4명 동일함을 확인)
match path1=(c:customer)-[:PURCHASED]->(o:"order")-[:ORDERS]->(p:product)-[:PART_OF]->(:category)
		, path2=(e:employee)-[:SOLD]->(o)
WHERE c.ID = 'ANTON' 
return path1, path2
limit 100;
*/
