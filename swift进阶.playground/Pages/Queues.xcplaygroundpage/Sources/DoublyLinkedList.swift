//双链表
public class Node<T>{
    
    public var value: T
    public var next: Node<T>?
    public var previous: Node<T>?
    
    public init(value: T) {
        self.value = value
    }
}

extension Node: CustomStringConvertible{
    
    public var description: String {
        String(describing: value)
    }
}

public class DoublyLinkedList<T>{
    private var head: Node<T>?
    private var tail: Node<T>?
    public init() {}
    
    public var isEmpty:Bool{
        head == nil
    }
    
    public var first:Node<T>?{
        head
    }
    public var last: Node<T>? {
      tail
    }
    
    public func prepend(_ value:T){
        
        let newNode = Node(value: value)
        guard let headNode = head else {
            head = newNode
            tail = newNode
            return
        }
        // [1<->2<->3] head = 1
        // [0<->1<->2<->3]
        
        newNode.previous = nil
        newNode.next = headNode
        headNode.previous = newNode
        
        head = newNode
    }
    
    public func append(_ value:T){
        let newNode = Node(value: value)
        
        guard let tailNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        tail!.previous = tailNode
        tailNode.next = newNode
        tail = newNode
        
    }
    
    public func remove(_ node:Node<T>)->T{
        
        // 1,2,3 node=2
        let prev = node.previous // 1
        let next = node.next // 3
        
        if let prev = prev {
            prev.next = next
        }else{//删除头部
            head = next
        }
        
        next?.previous = prev
        
        //删除尾部
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
        
    }
}

extension DoublyLinkedList:CustomStringConvertible{
    
    public var description: String{
        var  string = ""
        var current = head
        while let node = current {
            string.append("\(node.value) -> ")
            current = node.next
        }
        return string + "end"
        
    }
}

public class LinkedListIterator<T>:IteratorProtocol{
    
    private var current: Node<T>?
    
    init(node:Node<T>?) {
        current = node
    }
    
    public func next() -> Node<T>? {
        defer {
            current = current?.next
        }
        return current
    }
}

extension DoublyLinkedList: Sequence{
    
    public func makeIterator() -> LinkedListIterator<T> {
        LinkedListIterator(node: head)
    }
}



