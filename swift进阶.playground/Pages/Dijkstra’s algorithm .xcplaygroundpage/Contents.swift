/**
 Dijkstra的算法是贪婪算法。 贪心算法会逐步构建解决方案，并在每个步骤中选择最佳路径。 尤其是Dijkstra的算法可以找到有向图或无向图中顶点之间的最短路径。 给定图中的一个顶点，该算法将从起始顶点中查找所有最短路径。
 
 Dijkstra算法的其他一些应用包括：
 1.传染病传播：发现生物疾病传播最快的地方。
 2.电话网络：将呼叫路由到网络中可用的最大带宽路径。
 3.映射：查找旅行者的最短和最快路径。
 
 */
public enum Visited<T: Hashable> {
    case start
    case edge(Edge<T>)
}

public class Dijstra<T: Hashable> {
    public typealias Graph = AdjacencyList<T>
    let graph: Graph
    
    public init(graph: Graph) {
        self.graph = graph }
    
    public func route(to destination: Vertex<T>,
                      with paths: [Vertex<T>: Visited<T>]) ->
    [Edge<T>] {
        var vertex = destination
        var path : [Edge<T>] = []
        
        while let visit = paths[vertex] ,case .edge(let edge) = visit{
            path = [edge] + path
            vertex = edge.source
        }
        
        return path
        
    }
    
    public func distance(to destination: Vertex<T>,
                         with paths: [Vertex<T> : Visited<T>]) ->
    Double {
        let path = route(to: destination, with: paths)
        let distance = path.compactMap{$0.weight}
        return distance.reduce(0.0, +)
    }
    
    public func shortesPath(from start: Vertex<T>) -> [Vertex<T> : Visited<T>]{
        
    }
}
