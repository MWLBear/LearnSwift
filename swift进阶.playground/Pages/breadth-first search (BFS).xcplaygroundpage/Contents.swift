/**
 breadth-first search (BFS)
 
 一种这样的算法是广度优先搜索（BFS）算法。
 BFS可用于解决各种各样的问题：
 1.生成最小生成树。
 2.查找顶点之间的潜在路径。
 3.找到两个顶点之间的最短路径。
 
 
 关键点
 •广度优先搜索（BFS）是用于遍历或搜索图形的算法。
 •BFS在遍历下一级别的顶点之前先探索当前顶点的所有邻居。
 •当您的图形结构具有很多相邻的顶点或需要找出所有可能的结果时，通常最好使用此算法。
 •队列数据结构用于在深入更深层次之前优先遍历顶点的相邻边。
 
 
 */




let graph = AdjacencyList<String>()
let a = graph.createVertex(data: "A")
let b = graph.createVertex(data: "B")
let c = graph.createVertex(data: "C")
let d = graph.createVertex(data: "D")
let e = graph.createVertex(data: "E")
let f = graph.createVertex(data: "F")
let g = graph.createVertex(data: "G")
let h = graph.createVertex(data: "H")

graph.add(.undirected, from: a, to: b, weight: nil)
graph.add(.undirected, from: a, to: c, weight: nil)
graph.add(.undirected, from: a, to: d, weight: nil)
graph.add(.undirected, from: b, to: e, weight: nil)
graph.add(.undirected, from: c, to: f, weight: nil)
graph.add(.undirected, from: c, to: g, weight: nil)
graph.add(.undirected, from: e, to: h, weight: nil)
graph.add(.undirected, from: e, to: f, weight: nil)
graph.add(.undirected, from: f, to: g, weight: nil)


//graph.add(.undirected, from: a, to: b, weight: nil)
//graph.add(.undirected, from: a, to: c, weight: nil)
//graph.add(.undirected, from: a, to: d, weight: nil)
//graph.add(.undirected, from: b, to: e, weight: nil)
//graph.add(.undirected, from: c, to: g, weight: nil)
//graph.add(.undirected, from: e, to: f, weight: nil)
//graph.add(.undirected, from: e, to: h, weight: nil)
//graph.add(.undirected, from: f, to: g, weight: nil)
//graph.add(.undirected, from: f, to: c, weight: nil)

extension Graph where Element: Hashable {
    func breadthFirstSearch(form source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = QueueStack<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        while let vertex = queue.dequeue() {
            visited.append(vertex)
            let neighborEdges = edges(from: vertex)
            neighborEdges.forEach { (edge) in
                if !enqueued.contains(edge.destination) {
                    queue.enqueue(edge.destination)
                    enqueued.insert(edge.destination)
                }
            }
            
        }
        return visited
        
    }
}

let vertices = graph.breadthFirstSearch(form: a)
vertices.forEach { (vertex) in
    print(vertex)
}

//challenge2

extension Graph where Element: Hashable {
    func bfs(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = QueueStack<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        bfs(queue: &queue, enqueued: &enqueued, visited: &visited)
        
        return visited
        
    }
    
    private func bfs(queue: inout QueueStack<Vertex<Element>>,
                     enqueued: inout Set<Vertex<Element>>,
                     visited: inout [Vertex<Element>]){
        guard let vertex = queue.dequeue() else {
            return
        }
        
        visited.append(vertex)
        let neighborEdges = edges(from: vertex)
        neighborEdges.forEach { (edge) in
            if !enqueued.contains(edge.destination) {
                queue.enqueue(edge.destination)
                enqueued.insert(edge.destination)
            }
        }
        bfs(queue: &queue, enqueued: &enqueued, visited: &visited)
    }
    
}


//challenge 3

extension Graph where Element: Hashable {
    func isDisconnected() -> Bool {
        guard let firstVertex = allVertices.first else {
            return false
        }
        let visited = breadthFirstSearch(form: firstVertex)
        for vertex in allVertices {
            if !visited.contains(vertex) {
                return true
            }
        }
        return false
    }
}


/**
 在上一章中，您研究了广度优先搜索（BFS），在该搜索中，您必须先探索顶点的每个邻居，然后才能进入下一个级别。在本章中，您将研究深度优先搜索（DFS），这是用于遍历或搜索图形的另一种算法。
 DFS有很多应用程序：
 •拓扑排序。
 •检测周期。
 •找到路径，例如迷宫拼图中的路径。
 •在稀疏图中查找连接的组件。
 要执行DFS，请从给定的源顶点开始，并尝试尽可能地探索分支，直到到达终点为止。此时，您将回溯（向后移动）并探索下一个可用分支，直到找到所需的内容或访问了所有顶点为止。
 
 关键点
 •深度优先搜索（DFS）是遍历或搜索图形的另一种算法。
 •DFS尽可能探索分支直到到达末端。
 •利用堆栈数据结构来跟踪图形中的深度。 仅在达到死胡同时才弹出堆栈。
 
 
 */

extension Graph where Element: Hashable {
    func depthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        
        var stack: Stack<Vertex<Element>> = []
        var pushed: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        stack.push(source)
        pushed.insert(source)
        visited.append(source)
        
        outer: while let vertex = stack.peek(){
            let neighbors = edges(from: vertex)
            guard !neighbors.isEmpty else {
                stack.pop()
                continue
            }
            for edge in neighbors {
                if !pushed.contains(edge.destination) {
                    stack.push(edge.destination)
                    pushed.insert(edge.destination)
                    visited.append(edge.destination)
                    continue outer
                }
            }
            stack.pop()
        }
        
        return visited
    }
}
print("----")
let vertices1 = graph.depthFirstSearch(from: a)
vertices1.forEach { vertex in
  print(vertex)
}

// Challenge 2: Recursive DFS

extension Graph where Element: Hashable {
    
    func dfs(from start: Vertex<Element>) -> [Vertex<Element>] {
        var visited: [Vertex<Element>] = [] // 1
        var pushed: Set<Vertex<Element>> = [] // 2
        depthFirstSearch(from: start,
                         visited: &visited,
                         pushed: &pushed) // 3
        return visited
    }
    
    func depthFirstSearch(from source: Vertex<Element>,
                          visited: inout [Vertex<Element>],
                          pushed: inout Set<Vertex<Element>>) {
        pushed.insert(source) // 1
        visited.append(source)
        let neighbors = edges(from: source)
        for edge in neighbors { // 2
            if !pushed.contains(edge.destination) {
                depthFirstSearch(from: edge.destination, // 3
                                 visited: &visited,
                                 pushed: &pushed)
            }
        }
    }
}

//Challenge3 check cycle
extension Graph where Element: Hashable {
    func hasCycle(from source: Vertex<Element>) -> Bool {
        var pushed: Set<Vertex<Element>> = []
        
        return hasCycle(from: source, pushed: &pushed)
    }
    
    private func hasCycle(from source: Vertex<Element>,
                  pushed: inout Set<Vertex<Element>>) -> Bool {
        pushed.insert(source)
        
        let neihbors = edges(from: source)
        for edge in neihbors {
            if !pushed.contains(edge.destination) &&  hasCycle(from: edge.destination, pushed: &pushed) {
                return true
            }else if (pushed.contains(edge.destination )) {
                return true
            }
        }
        pushed.remove(source)
        return false
    }
}

graph.hasCycle(from: a)
