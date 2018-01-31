/*

그래프디비 전문기업 비트나인의 그래프모델 시각화도구 아젠스브라우저를 소개합니다.
아젠스브라우저는 그래프모델의 시각화를 통해 데이터에 대한 이해를 돕는 애플리케이션입니다.

그래프 데이터베이스는 node와 edge로 표현되는 graph 모델을 이용해 데이터를 표현하고 저장하는 데이터베이스입니다.

현실 세계의 다양한 데이터는 점점 더 복잡한 관계로 구성되어 쏟아져 나오고 있기 때문에 
전통적인 릴레이션 데이터베이스보다 데이터 관계를 표현하기 쉽고 이해하기 쉬운 수단으로서
그래프 데이터베이스에 대한 수요가 증가하고 있습니다.

아젠스브라우저는 그래프 데이터베이스 제품인 아젠스그래프에 연결되어 사용되는 데이터베이스 클라이언트이며
사이퍼라고 하는 그래프 언어를 통해 그래프 데이터를 질의하고 시각적으로 살펴볼 수 있습니다.

시각적으로 데이터를 탐색하는 것은 데이터를 이해하는 가장 직관적인 방법입니다.
질의한 결과를 시각적으로 살펴보고, 만져보거나 움직여 보면서 질문의 답을 찾아갈 수 있습니다.

그래프 데이터를 잘 탐색하기 위해서는 확실한 목적이 필요합니다.
일반적으로 시스템에 의해 생산된 데이터들은 비즈니스적인 질문에 직접적으로 답하기 어렵습니다.
안톤 이라는 고객의 구매 데이터는 구매된 상품과의 이력 관계만을 표현했기 때문에
안톤에게 어떤 상품을 추천해야 좋을지 등에 마케팅 목적의 질문에 답하려면
다른 관점으로 데이터를 이해해야 합니다. 

예를 들어, 안톤과 안톤이 자주 구매한 상품을 선호 한다는 관계로 정의하고
안톤과 구매 이력이 유사한 엘리자베스와 칼, 두 고객을 안톤과 유사 관계라 정의한다면
안톤에게 새로운 상품을 추천할 수 있는 비즈니스 관계 그래프가 만들어집니다.

이처럼 비즈니스 관계의 그래프는 안톤을 둘러싼 다양한 관계들을 조합하고 변형해서 만들어 지며
아젠스브라우저의 시각적인 상호작용을 통해서 생각보다 어렵지 않게 탐색적 분석을 수행할 수 있습니다.

그러면 이제부터 northwind 샘플 데이터를 가지고 
안톤에게 간단한 추천을 실행할 수 있는 비즈지스 관계 그래프를 만들어 보겠습니다.

준비한 northwind 그래프 데이터는 
노드 타입이 6개, 에지 타입 6개로 구성되어 있으며
고객은 91명, 주문이력은 830회, 판매된 상품은 77가지를 포함하고 있습니다.

이를 메타그래프를 통해 시각적으로 이해할 수 있습니다.
아젠스브라우저의 메인 페이지에서는 그래프데이터베이스의 접속 정보와 메타그래프를 살펴볼 수 있습니다.

메타그래프는 존재하는 그래프 데이터들의 연결 관계를 설명하는데,

고객과 주문이 연결되어 있고, 주문은 상품을 포함하고 있고 이를 판매한 사원이 있습니다.
상품은 공급자와 주문이력에 연결되어 있으며 카테고리로 묶이는 관계가 있습니다.
주문이력에 어떤 상품이 몇개나 포함되었는지 보려면 orders 관계가 갖고 있는 quantity 속성값을 보면 된다는 것을 알 수 있습니다.

이밖에 메인페이지에서는 노드나 에지의 라벨타입을 다이얼로그박스를 통해 생성하거나 삭제할 수 있습니다.

다음으로 그래프 쿼리를 수행할 수 있는 쿼리 페이지 입니다.
쿼리를 작성하는 쿼리 에디터창과 결과를 그래프로 보는 캔버스영역, 그리고 테이블영역이 있고요

작업에 사용된 쿼리는 그래프와 함께 프로젝트 관리 기능으로 저장하거나 다시 불러오기를 할 수 있습니다.
저장된 작업 하나를 불러 오겠습니다.

노드타입으로 커스터머와 오더, 그리고 프로덕트가 있고 에지타입으로 퍼처스드와 오더스가 있네요.
프로젝트에는 테이블 결과가 포함되지 않는데, 저장할 데이터 크기가 몹시 커질 수 있기 때문입니다.
테이블 내용을 보기위해 실행을 해 보겠습니다.

쿼리의 결과가 테이블로 출력되었고, 오브젝트 타입의 데이터라도 하단의 상세창을 통해 볼 수 있으며
클립보드로의 복사도 할 수 있습니다.

그러면 본격적으로 northwind 그래프를 탐색해 보겠습니다.

--------------------------

*/

-- 1) 일단 쿼리해보기
/*
우선 northwind 구매 데이터의 대략적인 모양을 알아보기 위해 구매 관계중 일부분을 쿼리해 보겠습니다.
*/
match path=(c:customer)-[:purchased]->(o:"order")-[r:orders]->(p:product) 
return path
limit 100;

/*
결과로 노드 120개와 에지 138개가 출력되었습니다. 기본 레이아웃은 cose가 적용되었습니다.
노드타입 커스터머와 오더, 프로덕트가, 에지타입으로 퍼쳐스드와 오더스가 포함되어 있는데
라벨타입별로 분리시켜 보겠습니다.

릴레이션 데이터베이스라면 아마도 이렇게 커스터머 데이터셋과 프로덕트 데이터셋 등이 분리된 형태로 
표현할 것입니다. 시각화 측면에서 이러한 표현방식은 구매관계의 전체 모습을 알아보기 어렵게 만듭니다.

그에 반해 그래프 모델은 전체 관계를 연결시켜 보는 것이 중요합니다.
다시 레이아웃을 적용시키고 구매 관계의 일부분을 분리해 보겠습니다.

코세2 레이아웃을 적용시키고

보기 편하도록 라벨별 스타일도 적용시켜 보겠습니다.
커스터머는 조금 크게 키우고, 오더는 매우 작게 크기를 변경하겠습니다.

다음으로 연결된 클러스터를 선택해 보겠습니다.
탐색 기준은 시작노드에서 에지타입이 중복되지 않도록 최대 3홉스 범위를 선택합니다.
연결된 노드를 클릭하면 기존 선택 범위에서 클러스터가 추가됩니다.

선택된 서브그래프만 화면에 나타나도록 하겠습니다.
바탕화면 팝업메뉴에서 hide unselect 클릭하고, dagre 레이아웃 적용해 보겠습니다.

이로써 일부 데이터지만 구매의 전체 관계를 온전히 살펴볼 수 있게 되었습니다.
이 내용을 이미지로 출력해 보겠습니다.

워터마크를 포함해서 northwind_sample 이란 제목을 입력합니다.
다음과 같이 출력되었습니다.

프로젝트로도 저장해 보겠습니다.

	1-2) 라벨별로 좌우로 분리 --> RDB 구조는 이처럼 시각화 하기 어려움
	1-1) 보기 편하게 스타일 적용 (고객은 크게, 주문은 작게)
	1-3) 레이아웃 설명
	1-4) COSE2 적용 
	1-5) findNeighbors 토글 적용 ==> 서브 그래프 단위로 살펴야 관찰이 쉬움을 설명
	1-6) 네이버와 상품을 선택 후, hide unselect 후 dagre 레이아웃 적용
	1-7) 선택 내용만 이미지 익스포트
*/

-- 이번에는 우리의 주인공, 안톤의 구매 그래프만 조회해 보겠습니다.

-- 2) ANTON 의 구매 그래프 조회
match path=(c:customer)-[:PURCHASED]->(o:"order")-[:ORDERS]->(p:product)-[:PART_OF]->(:category)
WHERE c.ID = 'ANTON' 
return path
limit 100;

/*
아젠스브라우저는 데이터의 이해를 돕기 위해 특정 노드로부터 연결된 다른 노드타입으로의 확장 기능을 제공하고 있습니다.
최대 20개까지 출력됩니다. 
오더에 대해 판매 사원을 확장기능으로 알아보겠습니다. 노드 위에서 마우스 오른쪽 버튼을 클릭하면
확장이 가능한 노드타입들의 리스트가 나타납니다.

	2-1) Dagre 레이아웃
	2-2) order에 대한 확장 ==> 판매사원 조회 (4명)
*/

/*
고객과 상품의 관계를 명료하게 보기 위해 rated 관계를 만들어 그래프를 단순화 시켜보겠습니다.
*/
-- 3) 고객별 상품 구매 순위 관계 만들기
drop elabel if exists RATED
;
create elabel if not exists RATED
;
MATCH (c:customer)-[:PURCHASED]->(o:"order")-[:ORDERS]->(p:product)
WITH c, count(p) as total
MATCH (c)-[:PURCHASED]->(o:"order")-[:ORDERS]->(p:product)
WITH c, total, p, count(o) as orders, round(count(o)*1.0/total,3) as rating
MERGE (c)-[rated:RATED {total_count: total, order_count: orders, rating: rating}]->(p)
;

/*
생성된 rated 관계를 이용하면 order 노드가 없는 형태로 고객과 상품의 관계가 나타납니다.
*/
-- 4) 안톤의 상품에 대한 구매 순위 알아보기
MATCH path = (c:customer)-[r:RATED]->(p:product)
where c.ID='ANTON'
RETURN c.ID as cid, r.total_count, p.productName, r.order_count as ord_cnt, r.rating, path
order by cid, ord_cnt desc
limit 100;

/*
rated 관계를 이용해 안톤과 동일한 상품을 구매한 다른 고객들의 연결관계를 일부만 살펴보겠습니다.
*/

-- 5) 안톤이 구매한 상품에 대해 비슷한 구매비율을 가지는 다른 고객 몇건만 살펴보기
match path=(c1:customer)-[r1:RATED]->(p:product)<-[r2:RATED]-(c2:customer)
where c1.ID='ANTON'
return c1.name as cust1, c2.name as cust2, p.productName, r1.rating as rating1, r2.rating as rating2, 
       abs(r1.rating::float-r2.rating::float) as difference, path
order by difference ASC
limit 15;

/*
	5-1) ANTON 을 lock 시키고
	5-2) DAGRE 레이아웃 적용 
	5-3) Neighbor 도구로 하일라이팅 : 캐서린과 매티
	==> 캐서린(MAISD)과 매티(WILMK)가 4개씩 가장 많은 공통점을 가지고 있음 

캐서린과 메티가 4개씩 가장 많은 공통점을 가지고 있음이 보여집니다.
이들은 아마도 안톤과 유사한 구매패턴 관계를 가지는 고객 후보가 될 수 있을겁니다.

이런 가정을 이용해 고객간의 코사인 유사도를 사이퍼 쿼리로 구해보겠습니다.
코사인 유사도는 고객 개별의 구매건에 대해 공통 구매건에 대한 비율로 구해지며,
코사인 유사도 값이 높을수록 구매 성향이 유사함을 의미합니다.


-- 6-1) 코사인 유사도의 외적에 해당하는 값을 rated 관계를 통해 구하고
-- 6-2) 같은 상품을 구매한 다른 고객과의 구매비율 내적을 구해서 외적으로 나누어 유사도 관계를 생성합니다.

*/

-- 6) 이런 가정을 이용해 고객간의 코사인 유사도를 구해봅시다
-- 6-1) 코사인 유사도의 외적에 해당하는 값을 rated 관계를 통해 구하고
match (c:customer)-[r:rated]->(p:product)
with c, count(p) as p_length , sqrt( sum( r.rating::float^2 ) ) as r_length
set c.p_length = to_json(p_length::int), c.r_length = to_json(r_length::float) 
;

-- 6-2) 같은 상품을 구매한 다른 고객과의 구매비율 내적을 구해서 외적으로 나누어 유사도 관계를 생성합니다.
drop elabel if exists SIMILARITY
;
create elabel if not exists SIMILARITY
;
MATCH (c1:customer)-[r1:RATED]->(p:product)<-[r2:RATED]-(c2:customer)
WITH c1, c2, SUM(r1.rating::float*r2.rating::float) as dot_product, count(p) as dot_length,
     c1.p_length as c1_plength, c2.p_length as c2_plength, c1.r_length as c1_rlength, c2.r_length as c2_rlength,
     SUM(r1.rating::float*r2.rating::float) / ( c1.r_length::float * c2.r_length::float ) as similarity
where dot_length > 3
merge (c1)-[:SIMILARITY { 
		dot_product: to_json(dot_product::float), 
		dot_length: to_json(dot_length::int), 
		score: to_json(similarity::float) 
		}]-(c2)
;

/*
고객간에 similarity라는 관계가 생성되었고, 안톤을 기준으로 상위 5개 유사 고객을 출력해 보겠습니다.
최상위 유사고객의 스코어는 0.4 얼마로 나타납니다.
*/
-- 6-3) 최상위 유사도 5명
--      ==> BOTTM, WHITC, SAVEA, ...
match path=(c1:customer)-[s:SIMILARITY]->(c2:customer)
where c1.ID='ANTON'
return path, c2.ID, s.score as s_score
order by s_score desc
limit 5;

/*
안톤에 대한 추천 상품은, 안톤이 아직 구매해지 않았지만
안톤의 유사고객군으로부터 지지받는 상품중에서 선택되어 제시한다고 합시다
이 때 유사고객군의 지지율은 그들의 구매비율 평균으로 계산합니다.

이것을 추천점수라 하고 

안톤을 기준으로 내림정렬로 100개만 출력해보겠습니다.
상위 4개 상품의 경우 추천점수가 0.05 점 이상을 보이고 있습니다.

추천 상품을 지지하는 유사고객군의 아이디는 다음과 같이 어레이로 출력되었습니다.

*/
-- 7) 안톤에 대해서 추천 점수가 0.05 이상인 상품 리스트
--    ==> 상품 4개 출력 : Nord-Ost Matjeshering, Guaraná Fantástica, Filo Mix, Uncle Bob's Organic Dried Pears
MATCH (me:customer)-[s:SIMILARITY]->(c:customer)-[r:RATED]->(p:product)
where me.id='ANTON' and not exists( (me)-[:RATED]->(p) )
with p, jsonb_agg( to_json(c.id::text) ) as neighbors, avg(s.score::float) as sim_avg
         , count(r) as rating_cnt, sum(r.rating::float) as rating_sum
         , sum(r.rating::float)/count(r) as recommend
return p.name as pname, neighbors, sim_avg, rating_cnt, rating_sum, recommend
order by recommend desc
limit 100;

/*
안톤에 대해 추천 상위 상품에 대해 recommend 관계를 만들어 보겠습니다.
추천 점수 0.05 이상만 생성하도록 했고

*/

-- 8) 안톤에 대해서 recommend 상품 관계 만들기 
--    단, 너무 많아서 추천점수에 제한을 두기로 하겠습니다.
drop elabel if exists RECOMMEND
;
create elabel if not exists RECOMMEND
;
MATCH (me:customer)-[s:SIMILARITY]->(c:customer)-[r:RATED]->(p:product)
where me.id='ANTON' and not exists( (me)-[:RATED]->(p) )
with me, p, jsonb_agg( to_json(c.id::text) ) as neighbors
         , count(r) as rating_cnt, sum(r.rating::float) as rating_sum
         , sum(r.rating::float)/count(r) as recommend
where recommend > 0.05
merge (me)-[:RECOMMEND {
				neighbors: neighbors,
				rating_cnt: to_json(rating_cnt::int),
				rating_sum: to_json(rating_sum::float),
				score: to_json(recommend::float)
      }]->(p)
;

/*
리콤멘드 관계를 통해 지지하는 유사고객군과 함께 시각적으로 살펴보겠습니다.
나타난 유사고객군은 아마도 어떤 유사점을 내포하고 있을 수 있습니다.
	군집된 고객군에 대해 어떤 특성을 발견할 수 있다면 
	또다른 비즈니스 관계 발견도 가능하지 않을까요?


*/
-- 9) recommend 상품에 대한 연관 고객군 나누어 보기
match path1=(c:customer)-[:RATED]->(p1:product), path2=(me:customer)-[:RECOMMEND]->(p1)
where me.id='ANTON'
return path1, path2
;

/*
이처럼 반복적인 질의와 시각적 탐색을 통해
비즈니스 데이터를 더욱 깊게 이해할 수 있을것입니다.

데모는 이것으로 마치겠습니다.
*/


-- 10) 슬라이드 마지막장
--     더 많은 정보를 원하면 비트나인 홈페이지를 방문해 주세요. 감사합니다.
