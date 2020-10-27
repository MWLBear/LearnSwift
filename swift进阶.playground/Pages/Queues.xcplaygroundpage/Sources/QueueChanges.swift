//Challenge 1: Stack vs. Queue
//Explain the difference between a stack and a queue. Provide two real-life examples for each data structure.
/**
 Stack : 1.摞盘子, 最后一个摞的,用的时候会被先拿
 键盘  ctrl+z 撤销功能,首先撤销最近的文本
 
 Queue: 看电影排队 ,先来排队的,检票的时候先出去
 打印机排队,
 */

//Challenge 2: Step-by-step Diagrams
/**
 [S]->[W]->[I]->[F]->[T]
 enqueue("R")
 enqueue("O")
 dequeue()
 enqueue("C")
 dequeue()
 dequeue()
 enqueue("K")
 
 
 
 Array
 [S]-[W]-[I]-[F]-[T]
 
 [S]-[W]-[I]-[F]-[T]-[R]-[]-[]-[]-[]
 enqueue("R")
 
 [S]-[W]-[I]-[F]-[T]-[R]-[O]-[]-[]-[]
 enqueue("O")
 
 [W]-[I]-[F]-[T]-[R]-[O]-[]-[]-[]-[]
 dequeue()
 
 [W]-[I]-[F]-[T]-[R]-[O]-[C]-[]-[]-[]
 enqueue("C")
 
 [I]-[F]-[T]-[R]-[O]-[C]-[]-[]-[]-[]
 dequeue()
 
 [F]-[T]-[R]-[O]-[C]-[]-[]-[]-[]-[]
 dequeue()
 
 [F]-[T]-[R]-[O]-[C]-[K]-[]-[]-[]-[]
 enqueue("K")
 
 
 Linked list
 [S]<->[W]<->[I]<->[F]<->[T]

 [S]<->[W]<->[I]<->[F]<->[T]<->[R]
 enqueue("R")
 
 [S]<->[W]<->[I]<->[F]<->[T]<->[R]<->[O]
 enqueue("O")
 
 [W]<->[I]<->[F]<->[T]<->[R]<->[O]
 dequeue()
 
 [W]<->[I]<->[F]<->[T]<->[R]<->[O]<->[C]
 enqueue("C")
 
 [I]<->[F]<->[T]<->[R]<->[O]<->[C]
 dequeue()
 
 [F]<->[T]<->[R]<->[O]<->[C]
 dequeue()
 
 [F]<->[T]<->[R]<->[O]<->[C]<->[K]
 enqueue("K")
 
 
 Ring buffer
 
 [ S ]-[ W ]-[ I ]-[ F ]-[ T ]
  wr
 
 [ S ]-[ W ]-[ I ]-[ F ]-[ T ]   enqueue("R") false
 wr
 
 [ S ]-[ W ]-[ I ]-[ F ]-[ T ]   enqueue("O") false
 wr
 
 [ S ]-[ W ]-[ I ]-[ F ]-[ T ]  dequeue()
  w         r
 
 [ C ]-[ W ]-[ I ]-[ F ]-[ T ]  enqueue("C")
       wr
 
 [ C ]-[ W ]-[ I ]-[ F ]-[ T ]  dequeue()
       w        r
 
 [ C ]-[ W ]-[ I ]-[ F ]-[ T ]  dequeue()
       w                  r
 
 [ C ]-[ K ]-[ I ]-[ F ]-[ T ]  enqueue("K")
            w       r
 
 
 Double stack
 

 enqueue("R")
 enqueue("O")
 [..]               [O]
 []                 [R]
 []                 [T]
 []                 [F]
 []                 [I]
 []                 [W]
 []                 [S]
left Stack      right Stack
 
 dequeue()
 enqueue("C")
 [W]               []
 [I]                  []
 [F]                 []
 [T]                 []
 [R]                 []
 [O]                 [C]
 left Stack      right Stack
  
 
dequeue()
dequeue()
 [F]                 []
 [T]                 []
 [R]                 []
 [O]                 [C]
 left Stack      right Stack
 
 
 enqueue("K")
 [F]                 []
 [T]                 []
 [R]                 [K]
 [O]                 [C]
 left Stack      right Stack
 */

//Challenge 3: Whose turn is it?

protocol BoardGameManager {
    associatedtype Player
    mutating func nextPlayer()->Player?
}

extension QueueArray:BoardGameManager {
    public typealias Player = T
    public mutating func nextPlayer() -> T? {
        guard let person = dequeue() else {
            return nil
        }
        enqueue(person)
        return person
    }
}

//Challenge 4: Reverse Queue
//
//extension QueueArray {
//
//    func reversed() -> QueueArray {
//        var queue = self
//        var stack = Stack<T>()
//
//        while let element = queue.dequeue() {
//            stack.push(element)
//        }
//        print("stack:\(stack)")
//        while let element = stack.pop() {
//            queue.enqueue(element)
//        }
//
//        return queue
//    }
//}






//Challenge 5: Double-ended Queue
