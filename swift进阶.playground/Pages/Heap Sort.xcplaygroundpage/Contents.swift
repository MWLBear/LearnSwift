struct Heap<Element: Equatable> {
  
  var elements: [Element] = []
  let sort: (Element, Element) -> Bool
  
  init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
    self.sort = sort
    self.elements = elements
    
    if !elements.isEmpty {
      for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
        siftDown(from: i, upTo: elements.count)
      }
    }
  }
  
  var isEmpty: Bool {
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
  
  mutating func remove() -> Element? {
    guard !isEmpty else {
      return nil
    }
    elements.swapAt(0, count - 1)
    defer {
      siftDown(from: 0, upTo: elements.count)
    }
    return elements.removeLast()
  }
  
  mutating func siftDown(from index: Int, upTo size: Int) {
    var parent = index
    while true {
      let left = leftChildIndex(ofParentAt: parent)
      let right = rightChildIndex(ofParentAt: parent)
      var candidate = parent
      if left < size && sort(elements[left], elements[candidate]) {
        candidate = left
      }
      if right < size && sort(elements[right], elements[candidate]) {
        candidate = right
      }
      if candidate == parent {
        return
      }
      elements.swapAt(parent, candidate)
      parent = candidate
    }
  }
  
  mutating func insert(_ element: Element) {
    elements.append(element)
    siftUp(from: elements.count - 1)
  }
  
  mutating func siftUp(from index: Int) {
    var child = index
    var parent = parentIndex(ofChildAt: child)
    while child > 0 && sort(elements[child], elements[parent]) {
      elements.swapAt(child, parent)
      child = parent
      parent = parentIndex(ofChildAt: child)
    }
  }
  
  mutating func remove(at index: Int) -> Element? {
    guard index < elements.count else {
      return nil // 1
    }
    if index == elements.count - 1 {
      return elements.removeLast() // 2
    } else {
      elements.swapAt(index, elements.count - 1) // 3
      defer {
        siftDown(from: index, upTo: elements.count) // 5
        siftUp(from: index)
      }
      return elements.removeLast() // 4
    }
  }
  
  func index(of element: Element, startingAt i: Int) -> Int? {
    if i >= count {
      return nil
    }
    if sort(element, elements[i]) {
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
}

extension Heap {
    func sorted() -> [Element] {
        var heap = Heap(sort: sort, elements: elements)
        for index in heap.elements.indices.reversed() {
            heap.elements.swapAt(0, index)
            heap.siftDown(from: 0, upTo: index)
        }
        return heap.elements
    }
}

let heap = Heap(sort: >, elements: [6, 12, 2, 26, 8, 18, 21, 9, 5])
print(heap.sorted())

//Challenge 1

extension Array where Element: Comparable {
    func leftChildIndex(ofParentAt index: Int) -> Int {
      (2 * index) + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
      (2 * index) + 2
    }
    
    mutating func siftDown(from index: Int, upTo size: Int) {
        
      var parent = index
      while true {
        let left = leftChildIndex(ofParentAt: parent)
        let right = rightChildIndex(ofParentAt: parent)
        var candidate = parent
        if (left < size) && (self[left] > self[candidate]) {
          candidate = left
        }
        if (right < size) && (self[right] > self[candidate]) {
          candidate = right
        }
        if candidate == parent {
          return
        }
        self.swapAt(parent, candidate)
        parent = candidate
      }
    }
    
    mutating func heapSort() {
        //创建堆
        if !isEmpty {
            for i in stride(from: count/2 - 1, through: 0, by: -1) {
                siftDown(from: i, upTo: count)
            }
        }
        //执行堆排序
        for index in indices.reversed() {
            swapAt(0, index)
            siftDown(from: 0, upTo: index)
        }
    }
}

var array = [6, 12, 2, 26, 8, 18, 21, 9, 5]
array.heapSort()
print(array)

let heap1 = Heap(sort: <, elements: [6, 12, 2, 26, 8, 18, 21, 9, 5])
print(heap1.sorted())

