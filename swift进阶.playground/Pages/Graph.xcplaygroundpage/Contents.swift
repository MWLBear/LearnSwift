/*
 
 关键点
 •您可以通过顶点和边表示真实世界的关系。
 •将顶点视为对象，将边视为对象之间的关系。
 •加权图将权重与每个边缘相关联。
 •有向图的边沿一个方向移动。
 •无向图的边指向两种方向。
 •邻接列表存储每个顶点的传出边列表。
 •邻接矩阵使用正方形矩阵表示图形。
 •当图的边数最少时，邻接表通常适用于稀疏图。
 •当图形具有许多边时，邻接矩阵通常适用于密集图形。
 
 **/

let graph = AdjacencyMatrix<String>()
let singapore = graph.createVertex(data: "Singapore")
let tokyo = graph.createVertex(data: "Tokyo")
let hongKong = graph.createVertex(data: "Hong Kong")
let detroit = graph.createVertex(data: "Detroit")
let sanFrancisco = graph.createVertex(data: "San Francisco")
let washingtonDC = graph.createVertex(data: "Washington DC")
let austinTexas = graph.createVertex(data: "Austin Texas")
let seattle = graph.createVertex(data: "Seattle")
graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)
print(graph)

let vertices = [1,2,3]

let array = [Double?](repeating: nil, count: vertices.count)
print(array)





//Solution to Challenge 2
let graph2 = AdjacencyList<String>()
let vincent = graph2.createVertex(data: "vincent")
let chesley = graph2.createVertex(data: "chesley")
let ruiz = graph2.createVertex(data: "ruiz")
let patrick = graph2.createVertex(data: "patrick")
let ray = graph2.createVertex(data: "ray")
let sun = graph2.createVertex(data: "sun")
let cole = graph2.createVertex(data: "cole")
let kerry = graph2.createVertex(data: "kerry")

graph2.add(.undirected, from: vincent, to: chesley, weight: 1)
graph2.add(.undirected, from: vincent, to: ruiz, weight: 1)
graph2.add(.undirected, from: vincent, to: patrick, weight: 1)
graph2.add(.undirected, from: ruiz, to: ray, weight: 1)
graph2.add(.undirected, from: ruiz, to: sun, weight: 1)
graph2.add(.undirected, from: patrick, to: cole, weight: 1)
graph2.add(.undirected, from: patrick, to: kerry, weight: 1)
graph2.add(.undirected, from: cole, to: ruiz, weight: 1)
graph2.add(.undirected, from: cole, to: vincent, weight: 1)
print(graph2)
print("Ruiz and Vincent both share a friend name Cole")

let vincentsFriends = Set(graph.edges(from: vincent).map{ $0.destination.data })

let mutual = vincentsFriends.intersection(graph.edges(from: ruiz).map { $0.destination.data })
print(mutual)

/*
 挑战1：计算路径数
 编写一种方法来计算有向图中两个顶点之间的路径数。下面的示例图包含从A到E的5条路径：
 
 **/
extension Graph where Element: Hashable {
    public func numbersOfPaths(from source: Vertex<Element>,
                               to destination: Vertex<Element>) ->Int{
        var numbersOfNumbers = 0
        var visited: Set<Vertex<Element>> = []
        
        paths(from: source, to: destination, vitited: &visited, pathCount: &numbersOfNumbers)
        
        return numbersOfNumbers
    }
    
    func paths(from source: Vertex<Element>,
               to destinaiton: Vertex<Element>,
               vitited: inout Set<Vertex<Element>>,
               pathCount: inout Int)  {
        vitited.insert(source)
        if source == destinaiton {
            pathCount += 1
        }else {
            let nightbors = edges(from: source)
            for edge in nightbors {
                if !vitited.contains(edge.destination) {
                    paths(from: edge.destination, to: destinaiton, vitited: &vitited, pathCount: &pathCount)
                }
            }
            
        }
    }
}
