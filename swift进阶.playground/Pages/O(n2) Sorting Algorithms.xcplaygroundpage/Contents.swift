import UIKit
/**

 O（n2）时间复杂度不是很好的性能，但是该类别的排序算法很容易理解，在某些情况下很有用。 这些算法节省空间。
 它们仅需要常数O（1）的额外存储空间。 对于小型数据集，这些排序与更复杂的排序相比非常有利。
 在本章中，您将研究以下排序算法：
 •气泡排序
 •选择排序
 •插入排序
 所有这些都是基于比较的排序方法。 他们依靠比较方法（例如小于运算符）对元素进行排序。
 进行此比较的次数是您如何衡量排序技术的总体性能。
 
 */


example(of: "reversed ") {
    let arry = [1,2,3,4]
    let a = (1..<arry.count).reversed()

    for s in a {
        print(s)
    }
}

example(of: "bubble sort") {
    var arry = [9,4,3,10]
    print("Origianl: \(arry)")
    bubbleSort(&arry)
    print("Bubble sorted: \(arry)")
}

example(of: "selection sort") {
  var array = [9, 4, 10, 3]
  print("Original: \(array)")
  selectionSort(&array)
  print("Selection sorted: \(array)")
}

example(of: "insertion sort") {
  var array = [9, 4, 10, 3]
  print("Original: \(array)")
  insertionSort(&array)
  print("Insertion sorted: \(array)")
}

example(of: "test") {
    var array = [9,4,10,3]
    let start = array.startIndex
    let next = array.index(after: start)
    
    print(array.indices.reversed())
    print(array.index(before: array.endIndex))
    print(start)
    print(next)

    
}

/**
 
 Challenge 1: Group elements
 Given a collection of Equatable elements, bring all instances of a given value in the array to the right side of the array.
 Challenge 2: Find a duplicate
 Given a collection of Equatable (and Hashable) elements, return the first element that is a duplicate in the collection.
 Challenge 3: Reverse a collection
 Reverse a collection of elements by hand. Do not rely on the reverse or reversed methods.
 
 
 */

extension MutableCollection
    where Self: BidirectionalCollection, Element: Equatable {
    mutating func rightAlign(value: Element) {
        var left = startIndex
        var right = index(before: endIndex)
        while left < right {
            while self[right] == value {
                formIndex(before: &right) //将给定索引替换为其前身
            }
            while self[left] != value {
                formIndex(after: &left) ///将给定的索引替换为其后继
            }
            guard left < right else {
                return
            }
            swapAt(left, right)
        }
    }
}

example(of: "Challenge 1") {
    var array = [1,2,3,4,3]
    array.rightAlign(value: 3)
    print(array)
}


extension Sequence where Element: Hashable {
    var firstDuplicate: Element?{
        var found: Set<Element> = []
        for value in self {
            if found.contains(value) {
                return value
            }else{
                found.insert(value)
            }
        }
        return nil
    }
}

example(of: "challenge2") {
    let array = [1,2,3,4,3]

    print(array.firstDuplicate)
}

//双重引用法
extension MutableCollection
    where Self: BidirectionalCollection{
    mutating func reverse(){
        var left = startIndex
        var right = index(before: endIndex)
        print("left: \(left)")
        print("right: \(right)")
        while left < right {
            swapAt(left, right)
            formIndex(after: &left)
            formIndex(before: &right)
        }
        
    }
}

example(of: "challenge3") {
    var array = [1,2,3,4,5]
    array.reverse()
    print(array)
}
