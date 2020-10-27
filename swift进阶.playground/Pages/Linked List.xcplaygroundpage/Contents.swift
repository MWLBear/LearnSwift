//: [Previous](@previous)

import Foundation
/**
 characteristics:
 
 1. push: Adds a value at the front of the list.
 2. append: Adds a value at the end of the list.
 3. insert(after:): Adds a value after a particular node of the list.
 
 
 
 
 节点
 1.value
 2.对下一个节点的引用 尾结点 nil
 
 关键点
 •链接列表是线性和单向的。 将参考从一个节点移动到另一个节点后，您将无法返回。
 •头开始插入时，链接列表的时间复杂度为O（1）。 头先插入时，Arry的时间复杂度为O（n）。
 •遵循Swift收集协议，例如Sequence和Collection提供了许多有用的方法，可满足相当少量的需求。
 •写时复制行为使您可以实现值语义。
 
 
 */

example(of: "creating and list nodes") {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)

    node1.next = node2
    node2.next = node3
    
    print(node1)
}

example(of: "push") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)

    print(list)
}

example(of: "append") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    print(list)
}

example(of: "inserting at a particular index") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before insert:\(list)")
    var middleNode = list.node(at: 1)!
    for _ in 1...4 {
       middleNode = list.insert(-1, after: middleNode)
    }
    
    print("After instering:\(list)")
    
}

example(of: "pop") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)

    print("Before poping list: \(list)")
    let popedValue = list.pop()
    print("After poping list:\(list)")
    print("Popped value:"+String(describing: popedValue))
}

example(of: "removing a node after a paricular node") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    print("Before removing at particular index:\(list)")
    
    let index = 1
    let node = list.node(at: index-1)!
    let removeValue = list.remove(after: node)
    print("After removing at index:\(index): \(list)")
    print("Remove value: "+String(describing: removeValue))
    
}

example(of: "using collection") {
    var list = LinkedList<Int>()
    for i in 0...9 {
        list.append(i)
    }
    
    print("List:\(list)")
    print("First element:\(list[list.startIndex])")
    print("Array containing first 3 elements: \(Array(list.prefix(3)))")
    print("Array containing last 3 elemetn:\(Array(list.suffix(3)))")
    
    let sum = list.reduce(0, +)
    print("sum of all values:\(sum)")
    
}

//值语义 和写时复制 copy-on-write

example(of: "array cow") {
    let arry1 = [1,2]
    var arry2 = arry1
    
    print("arry1: \(arry1)")
    print("arry2: \(arry2)")
    
    print("After adding 3 to arry 2")
    arry2.append(3)
    
    print("arry1: \(arry1)")
    print("arry2: \(arry2)")
       
    
}

example(of: "Linked list cow") {
    var list1 = LinkedList<Int>()
    list1.append(1)
    list1.append(2)
    var list2 = list1
    
    print("list1: \(list1)")
    print("list2: \(list2)")
    

    print("After appending 2 to list2")
    list2.append(3)
    
    print("list1: \(list1)")
    print("list2: \(list2)")
    
    print("Removing middle node on list2")
    if let node = list2.node(at: 0) {
        list2.remove(after: node)
    }
    print("list2: \(list2)")
}

//Challenge 1: Print in reverse

//O(n)->O(n)
private func printInReverse<T>(_ node:Node<T>?){
    guard let node = node else { return }
    printInReverse(node.next)
    print(node.value)
    
    //递归调用之后的任何代码都只有在基本情况触发后才被调用（即递归函数到达列表末尾之后）。随着递归语句的分解，节点数据被打印出来。
    //每次调用一次函数，都是等它彻底执行完毕之后，才会返回去继续执行
    
}

func printInReverse<T>(_ list:LinkedList<T>){
    printInReverse(list.head)
}

public func printNodeResverse<T>(_ listNodes:LinkedList<T>){
    
    for li in listNodes.reversed() {
        print(li)
    }
}

example(of: "printing in reverse") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)

    print("list: \(list)")
    printInReverse(list)
//    printNodeResverse(list)
}

//Challenge 2: Find the middle node

func findMiddleNodeIndex(_ lists:LinkedList<Int>?)->Node<Int>?{

    guard var list = lists else{return nil}
    let node = list.node(at: list.count/2)
    return node
}

//快慢指针
func getMiddle<T>(_ list: LinkedList<T>) -> Node<T>? {
    var slow = list.head
    var fast = list.head
    
    while let nextFast = fast?.next {
        
        fast = nextFast.next
        slow = slow?.next
    }
    
    return slow
    
}


example(of: "Find the middle node") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    list.append(4)
    list.append(5)

    print("list: \(list)")

    let node = findMiddleNodeIndex(list)
    let node1 = getMiddle(list)
    
    print("moddleNode:\(node!.value)")
    print("moddleNode1:\(node1!.value)")

}

//Challenge 3: Reverse a linked list
public func listResverse<T>(_ listNodes:LinkedList<T>?)->LinkedList<T>?{
    guard let listNode = listNodes else{ return nil }
    
    var newList = LinkedList<T>()
    for li in listNode {
        newList.push(li)
    }
    return newList
}

example(of: "Reverse a linked list") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    
    print("reverse list :\(listResverse(list)!)")
    list.reverse1()
    print("resverse: \(list)")
}

//Challenge 4: Merge two lists
/**
 // list1
 1 -> 4 -> 10 -> 11
 // list2
 -1 -> 2 -> 3 -> 6
 // merged list
 -1 -> 1 -> 2 -> 3 -> 4 -> 6 -> 10 -> 11
 
 */


func mergoList<T> (_ left:LinkedList<T>,_ right:LinkedList<T>)->LinkedList<T> where T:Comparable{
    
    guard !left.isEmpty else{ return right }
    guard !right.isEmpty else{ return left }
   
    var newHead:Node<T>?
    
    var tail:Node<T>?
    var currentLeft = left.head
    var currentRight = right.head
    
    if let leftNode = currentLeft,let rightNode = currentRight {
        
        if leftNode.value < rightNode.value {
            newHead = leftNode
            currentLeft = leftNode.next
        }else{
            newHead = rightNode
            currentRight = rightNode.next
        }
        tail = newHead
    }
    
    /**
     list1: 1 -> 4 -> 10 -> 11
     list2: -1 -> 2 -> 3 -> 6
     
      
      newHead =  -1
      tail = -1
     
     list1: 1 -> 4 -> 10 -> 11
     list2:  2 -> 3 -> 6
     
     -1->1->2->3->4->6
     list1:  10 -> 11
     list2:
      
     
     */
    while let leftNode = currentLeft,let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            tail?.next = leftNode
            currentLeft = leftNode.next
        }else{
            tail?.next = rightNode
            currentRight = rightNode.next
        }
        tail = tail?.next
    }
    
    if let leftNodes = currentLeft {
        tail?.next = leftNodes
    }
    if let rightNodes = currentRight{
        tail?.next = rightNodes
    }
    
    var list = LinkedList<T>()
    list.head = newHead
    list.tail = {
        while let next = tail?.next {
            tail = next
        }
        return tail
    }()
    
    return list
    
}

example(of: "Merge two lists") {
    
    var list1 = LinkedList<Int>()
    list1.append(1)
    list1.append(8)
    list1.append(9)

    var list2 = LinkedList<Int>()
    list2.append(3)
    list2.append(6)
    list2.append(10)

    
    print("list1: \(list1)")
    print("list2: \(list2)")

    
    print("mergoList: \(mergoList(list1, list2))")

}

//Challenge 5: Remove all occurrences
// original list
//1 -> 3 -> 3 -> 3 -> 4
// list after removing all occurrences of 3
//1 -> 4

extension LinkedList where Vaule:Equatable{
    mutating func removeAll(_ value:Vaule) {
        while let head = head, head.value == value {
            self.head = head.next
        }
        var prev = head
        var current = head?.next
        // 1,2,3,5
        while let currentNode = current {
            guard currentNode.value != value else{
                prev?.next = currentNode.next
                current = prev?.next
                continue
            }
            prev = current
            current = current?.next
        }
        tail = prev
    }
}

example(of: "deleting duplicate nodes") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    list.append(3)
    list.append(4)

    print("before remove list:\(list)")
    list.removeAll(2)
    print(list)
}

