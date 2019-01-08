graph = TinkerGraph.open()
graph.io(graphson()).readGraph('temp/gid_1038.json')
g = graph.traversal()

g.V().sample(5).id()

g.V().hasLabel('customer').groupCount().by('country ').unfold()
==>USA=13
==>Argentina=3
==>Switzerland=2
==>Portugal=2
==>Spain=4
==>Canada=3
==>...

## 두개 이상의 속성값으로 Vertex group by 하기
g.V().hasLabel('customer').group().by(values('country','city').fold()).unfold()
==>[Germany, Brandenburg]=[v[8.39]]
==>[Sweden, Bräcke]=[v[8.24]]
==>[Spain, Sevilla]=[v[8.30]]
==>[Germany, Köln]=[v[8.56]]
==>...

## Vertex - outE -> inV 까지 Map 출력하기
g.V().hasLabel('customer').as('a').outE().as('b').inV().as('c').select('a','b','c').by('country').by(id).by(id)
==>[a:USA,b:10.333,c:9.332]
==>[a:Canada,b:10.248,c:9.248]
==>[a:Canada,b:10.374,c:9.373]
==>[a:USA,b:10.235,c:9.235]
==>[a:USA,b:10.299,c:9.298]
==>[a:Mexico,b:10.379,c:9.378]
==>[a:Mexico,b:10.61,c:9.61]
