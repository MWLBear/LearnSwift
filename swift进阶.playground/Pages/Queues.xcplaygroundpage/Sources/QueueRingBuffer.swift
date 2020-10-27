public struct QueueRingBuffer<T>:Queue{
    public mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
    
    public mutating func dequeue() -> T? {
        ringBuffer.read()
    }
    
    private var ringBuffer: RingBuffer<T>
    
    public init(count:Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }
    
    public var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    
    public var peek: T? {
        ringBuffer.first
    }
    
}
extension QueueRingBuffer: CustomStringConvertible {
  public var description: String {
   String(describing: ringBuffer)
  }
}
