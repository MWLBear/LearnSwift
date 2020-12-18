public enum EdgeType {
    case directed
    case undirected
}


public protocol Graph {
    associatedtype Element
    //创建一个顶点并将其添加到图形中。
    func createVertex(data: Element) -> Vertex<Element>
    //在两个顶点之间添加有向边。
    func addDircetedEdge(from source: Vertex<Element>,
                         to destination: Vertex<Element>,
                         weight: Double?)
    //在两个顶点之间添加无向（或双向）边。
    func addUndirectedEdge(beween source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?)
    //使用EdgeType在两个顶点之间添加有向或无向边。
    func add(_ edge: EdgeType, from source: Vertex<Element>,
             to destination: Vertex<Element>,
             weight: Double?)
    //返回特定顶点的传出边列表。
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    //返回两个顶点之间的边的权重
    func weight(from source: Vertex<Element>,
                to destination: Vertex<Element>) -> Double?
}

extension Graph {
    
    public func addDircetedEdge(from source: Vertex<Element>,
                                 to destination: Vertex<Element>,
                                 weight: Double?) {
        addDircetedEdge(from: source, to: destination, weight: weight)
        addDircetedEdge(from: destination, to: source, weight: weight)
    }
    func add(_ edge: EdgeType, from source: Vertex<Element>,
             to destination: Vertex<Element>,
             weight: Double?){
        switch edge {
        case .directed:
            addDircetedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(beween: source, and: destination, weight: weight)
        }
    }
}
