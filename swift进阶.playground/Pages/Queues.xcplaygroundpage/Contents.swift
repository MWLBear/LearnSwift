//: [Previous](@previous)

import Foundation
/**
 
 
 FIFO -> first-in first-out
 meaning the first element that was added will always be the first to be removed.
 
 
 
 */

var queue = QueueArray<String>()
queue.enqueue("Bay")
queue.enqueue("Brain")
queue.enqueue("Eric")

print(queue)
queue.dequeue()
print(queue)
queue.peek

var doublist = DoublyLinkedList<Int>()
doublist.append(1)
doublist.append(2)
doublist.append(3)
doublist.append(4)

print(doublist)

for list in doublist{
    print(list)
}

var queue1 = QueueLinkedList<String>()
queue1.enqueue("Ray")
queue1.enqueue("Brian")
queue1.enqueue("Eric")
print(queue1)
queue1.dequeue()
print(queue1)
queue1.peek

var buffer = RingBuffer<Int>(count: 4)
buffer.write(1)
buffer.write(2)
buffer.write(3)
buffer.write(4)

print("buffer :\(buffer)")

var queue2 = QueueRingBuffer<String>(count: 10)
queue2.enqueue("Ray")
queue2.enqueue("Brian")
queue2.enqueue("Eric")

print("QueueRingBuffer: \(queue2)")
queue2.dequeue()
print("QueueRingBuffer: \(queue2)")
queue2.peek

var queue3 = QueueStack<String>()
queue3.enqueue("Ray")
queue3.enqueue("Brian")
queue3.enqueue("Eric")
queue3
queue3.dequeue()
queue3
queue3.peek


var queue4 = QueueArray<String>()
queue4.enqueue("Vincent")
queue4.enqueue("Remel")
queue4.enqueue("Lukiih")
queue4.enqueue("Allison")
print(queue4)
print("===== boardgame =======")
queue4.nextPlayer()
print(queue4)
queue4.nextPlayer()
print(queue4)
queue4.nextPlayer()
print(queue4)
queue4.nextPlayer()
print(queue4)



//Challenge 4: Reverse Queue

extension QueueArray {
    
    func reversed() -> QueueArray {
        var queue = self
        var stack = Stack<T>()
        
        while let element = queue.dequeue() {
            stack.push(element)
        }
        print("stack:\(stack)")
        while let element = stack.pop() {
            queue.enqueue(element)
        }
        
        return queue
    }
}


var queue5 = QueueArray<Int>()
queue5.enqueue(1)
queue5.enqueue(2)
queue5.enqueue(3)
queue5.enqueue(4)

print("queue:\(queue5)")
let resverQueue = queue5.reversed()
print("resverQueue:\(resverQueue)")



//Challenge 5: Double-ended Queue
//双端队列（也称为双端队列）是一个队列，可以在前面或后面添加或删除元素。

//双端队列可以同时视为队列和堆栈。

enum Direction {
    case front
    case back
    
}
protocol Deque {
    
    associatedtype Element
    var isEmpty: Bool { get }
    func peek(from direction: Direction) -> Element?
    mutating func enqueue(_ element: Element,
                          to direction: Direction) -> Bool
    mutating func dequeue(from direction: Direction) -> Element?
}

class DequeDoubleLinkedList<Element>: Deque {
    private var list = DoublyLinkedList<Element>()
    public init() {}
    var isEmpty: Bool {
        list.isEmpty
    }
    
    func peek(from direction: Direction) -> Element? {
        switch direction {
        case .front:
            return list.first?.value
        case .back:
            return list.last?.value
        }
    }
    
    func dequeue(from direction: Direction) -> Element? {
        let element: Element?
        
        switch direction {
        case .front:
            guard let first = list.first else { return nil }
            element = list.remove(first)
        case .back:
            guard let last = list.last else { return nil }
            element = list.remove(last)
        }
        return element
    }
    
    func enqueue(_ element: Element, to direction: Direction) -> Bool {
        switch direction {
        case .front:
            list.prepend(element)
        case .back:
            list.append(element)
        }
        return true
    }
}

extension DequeDoubleLinkedList: CustomStringConvertible{
   public var description: String{
        String(describing: list)
    }
}

let deque = DequeDoubleLinkedList<Int>()
deque.enqueue(1, to: .back)
deque.enqueue(2, to: .back)
deque.enqueue(3, to: .back)
deque.enqueue(4, to: .back)
print(deque)
deque.enqueue(5, to: .front)
print(deque)
deque.dequeue(from: .back)
deque.dequeue(from: .back)
deque.dequeue(from: .back)
deque.dequeue(from: .front)
deque.dequeue(from: .front)
deque.dequeue(from: .front)
print(deque)
