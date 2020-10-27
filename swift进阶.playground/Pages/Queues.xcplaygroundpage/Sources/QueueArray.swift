public struct QueueArray<T>:Queue{

   private var arry: [T] = []
   public init() {}
   public var isEmpty: Bool{
       arry.isEmpty
   }
   public var peek: T?{
       arry.first
   }
   public mutating func dequeue() -> T? {
       isEmpty ? nil : arry.removeFirst()
   }
   
   public mutating func enqueue(_ element: T) -> Bool {
       arry.append(element)
       return true
   }
}
extension QueueArray:CustomStringConvertible{
   public var description: String{
       String(describing: arry)
   }
}
