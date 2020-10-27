import Foundation

public class Node<Value>{
    public var value:Value
    public var next:Node?
    
    public init(value: Value,next:Node? = nil){
        self.value = value
        self.next = next
    }
}

extension Node:CustomStringConvertible{
    public var description: String{
        guard let next = next else{
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + ""
    }
}

public struct LinkedList<Vaule>{
    
    public var head:Node<Vaule>? //头
    public var tail:Node<Vaule>? //尾
    
    public init(){}
    
    public var isEmpty:Bool{
        head == nil
    }
    //头插法
    public mutating func push(_ value:Vaule){
       copyNodes()

        
//        let temp = Node(value: value)
//        temp.next = head
//        head = temp
 
        // [] head = nil
        // [1,2,3] head=1
        //[0,1,2,3]
        head = Node(value: value, next: head)
       
        if tail == nil{
            tail = head
        }
    }
    //尾插法
    public mutating func append(_ value:Vaule){
        copyNodes()
        guard !isEmpty else{
            push(value)
            return
        }
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    public mutating func node(at inedex:Int)->Node<Vaule>?{
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil && currentIndex < inedex {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
        
    }
    
    @discardableResult
    public mutating func insert(_ value:Vaule,after node:Node<Vaule>)->Node<Vaule>{
        copyNodes()
        guard tail !== node else{
            append(value)
            return tail!
        }
        //node = 2  node.next = 3
        // newnode -1
        //[1,2,3]
        //[1,2,-1,3]
        node.next = Node(value: value, next: node.next)
        return node.next!
        
    }
    
    @discardableResult
    public mutating func pop()->Vaule?{
        copyNodes()

        defer{ //defer block 里的代码会在函数 return 之前执行
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast()->Vaule?{
        copyNodes()
        guard let head = head else{ //没有节点
            return nil
        }
        
        guard head.next != nil else{ //仅有一个节点
            return pop()
        }
        
        var prev = head
        var current = head
        
        //[1,2,3]
        //current = 1
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        
        return current.value
        
    }
    
    @discardableResult
    public mutating func remove(after node:Node<Vaule>)->Vaule?{
        guard let node = copyNodes(returningCopyof: node) else { return nil }
        
        defer {
            if node.next === tail{
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    //copy-on-write
    
    /**
     isKnownUniquelyReferenced
     
     Sharing nodes
     

     */
    private mutating func copyNodes(){
        guard !isKnownUniquelyReferenced(&head) else{ return }
        guard var oldNode = head else{ return }
        
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode?.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        tail = newNode
    }
    
    private mutating func copyNodes(returningCopyof node:Node<Vaule>?)->Node<Vaule>?{
        guard !isKnownUniquelyReferenced(&head) else { return nil }
        guard var oldNode = head else { return nil }
        
        head = Node(value: oldNode.value)
        var newNode = head
        var nodeCopy:Node<Vaule>?
        
        while let nextOldNode = oldNode.next {
            if oldNode === node {
                nodeCopy = newNode
            }
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
           
            oldNode = nextOldNode
        }
        
        return nodeCopy
    }
    
    
}

extension LinkedList:CustomStringConvertible{
    public var description: String{
        guard let head = head else{
            return "Empty List"
        }
        return String(describing: head)
    }
}

extension LinkedList:Collection{
    
    public var startIndex: Index {
        Index(node: head)
    }
    
    public var endIndex: Index {
        Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    

    public subscript(position: Index) -> Vaule {
        position.node!.value
    }
    
    public struct Index:Comparable{
        
        public var node:Node<Vaule>?
        
        static public func ==(lhs:Index,rhs:Index)->Bool{
            switch (lhs.node,rhs.node) {
            case let (left?,right?):
                return left.next === right.next
            case (nil,nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs:Index,rhs:Index)->Bool{
            guard lhs != rhs else{
                return false
            }
            let nodes = sequence(first: lhs.node) {$0?.next}
            return nodes.contains {$0 === rhs.node}
        }
    }
}


extension LinkedList{
    
    //The easy way
   public mutating func reverse() {
        var tmpList = LinkedList<Vaule>()
        for value in self {
            tmpList.push(value)
        }
        head = tmpList.head
    }
    
   public mutating func reverse1() {
        tail = head
        var prev = head  //1
        var current = head?.next //2
        prev?.next = nil
        
        // 1->2->3
        //1<-2<- 3
        
        while current != nil {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        
        head = prev
    }
    
}

