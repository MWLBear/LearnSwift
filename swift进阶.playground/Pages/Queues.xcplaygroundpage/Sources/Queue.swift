 public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element:Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty:Bool { get }
    var peek:Element? { get }
}

 /**
  
  
  The protocol describes the core operations for a queue:
  
  • enqueue: Insert an element at the back of the queue. Returns true if the operation was successful.
  • dequeue: Remove the element at the front of the queue and return it.
  • isEmpty: Check if the queue is empty.
  • peek: Return the element at the front of the queue without removing it.
  
  
  
  Using an array
  • Using a doubly linked list
  • Using a ring buffer
  • Using two stacks
  
  •使用数组
  •使用双向链表
  •使用环形缓冲区
  •使用两个堆栈
  
  
  键点
  •队列采用FIFO策略，首先添加的元素也必须先删除。
  •Enqueue将元素插入队列的后面。
  •出队将删除队列前面的元素。
  •数组中的元素布置在连续的内存块中，而链表中的元素则更分散，有可能导致高速缓存未命中。
  •基于环形缓冲区队列的实现非常适合具有固定大小的队列。
  •与其他数据结构相比，利用两个堆栈可改善,将时间复杂度出队 dequeue(_:) 摊销为O（1）运算。
  •在空间位置方面，双栈实施优于链表。

  
  */
// •使用数组
 

 
