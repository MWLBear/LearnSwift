/**

 什么是堆？
 堆是可以使用数组构造的完整的二叉树，也称为二叉堆。
 
 堆有两种口味：
 1.最大堆，其中具有较高值的元素具有较高优先级。
 2.最小堆，其中值较低的元素具有较高的优先级。
 
 堆属性
 堆具有必须始终满足的重要特征。 这称为堆不变式或堆属性。
 
 在最大堆中，父节点必须始终包含一个大于或等于其子节点中的值的值。 根节点将始终包含最大值。
 在最小堆中，父节点必须始终包含一个小于或等于其子节点中的值的值。 根节点将始终包含最小值。
 
 堆的另一个重要属性是它是完整的二叉树。 这意味着除最后一个级别外，每个级别都必须填写。
 
 堆应用
 堆的一些有用的应用程序包括：
 •计算集合的最小或最大元素。
 •堆排序。
 •构建优先级队列。
 •使用优先级队列构造图算法，例如Prim算法或Dijkstra算法。
 
 */


struct Heap<Element: Equatable> {
    
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    init(sort: @escaping (Element ,Element) -> Bool,
         elements: [Element] = [] ) {
        self.sort = sort
        self.elements = elements
        buildHeap()
    }
    
    mutating func buildHeap() {
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1 , through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }
    
    var isEmpty :Bool {
        elements.isEmpty
    }
    
    var count: Int {
        elements.count
    }
    
    func peek() -> Element? {
        elements.first
    }
    
    func leftChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }
    
    // O(log n)
    mutating func remove() -> Element? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(from: 0)
        }
        return elements.removeLast()
    }
    
    mutating func siftDown(from index : Int){
        
        var parent = index
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            
            var candidate = parent
            if left < count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            
            if right<count && sort(elements[right],elements[candidate]) {
                candidate = right
            }
            
            if candidate == parent {
                return
            }
            elements.swapAt(parent, candidate)
            parent = candidate
            
        }
        
    }
    
    // O(log n)
    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    
    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child],elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
    
    // O(log n)
    mutating func remove(at index: Int) -> Element? {
        
        guard index < elements.count else {
            return nil
        }
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count - 1)
            defer {
                siftDown(from: index)
                siftUp(from: index)
            }
            return elements.removeLast()
        }
        
    }
    
    func index(of element:Element, startingAt i: Int) -> Int? {
        if i > count {
            return nil
        }
        if sort(element,elements[i]) {
            return nil
        }
        if element == elements[i] {
            return i
        }
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
            return j
        }
        
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
            return j
        }
        return nil
        
    }
    
    mutating public func merge(heap:Heap) {
        elements = elements + heap.elements
        buildHeap()
    }
}

var heap = Heap(sort: <, elements: [1,12,3,4,1,6,8,7])
while !heap.isEmpty {
    print(heap.remove()!)
    
}
let arry = [1,12,3,4,1,6,8,7]

for i in stride(from: arry.count / 2 - 1, through: 0, by: -1) {
    print("i:\(i)")
}

//challenges
//Challenge 1: Find the nth smallest integer
func getNthSmallesElement(n:Int, elements: [Int]) -> Int? {
    var heap = Heap(sort: <,elements: elements)
    var current = 1
    while !heap.isEmpty {
        let element = heap.remove()
        if element == n {
            return current
        }
        current += 1
    }
    return nil
}


//Challenge 2: Step-by-Step diagram




//Challenge 3: Combining two heaps

let elements = [21, 10, 18, 5, 3, 100, 1]
let elements2 = [8, 6, 20, 15, 12, 11]
var heap1 = Heap(sort: <, elements: elements)
var heap2 = Heap(sort: <, elements: elements2)

heap1.merge(heap: heap2)
print(heap1)


//Challenge 4: A Min Heap?
func leftChildIndex(ofParentAt index: Int) -> Int {
  (2 * index) + 1
}
func rightChildIndex(ofParentAt index: Int) -> Int {
  (2 * index) + 2
}

func isMinHeap<Element: Comparable>(elements: [Element]) -> Bool {
    guard !elements.isEmpty else {
        return false
    }
    for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
        
        let left = leftChildIndex(ofParentAt: i)
        let right = rightChildIndex(ofParentAt: i)
        if elements[left] < elements[i]{
            return false
        }
        if right < elements.count && elements[right] < elements[i] {
            return false
        }
    }
    return true
}
