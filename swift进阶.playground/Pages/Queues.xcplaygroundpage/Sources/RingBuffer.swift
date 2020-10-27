public struct RingBuffer<T> {
    
    private var arry: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    public init(count:Int){
        arry = Array<T?>(repeating: nil, count: count)
    }
    public var first: T?{
        arry[readIndex]
    }
    
    public mutating func write(_ element: T) -> Bool {
        
        if !isFull {
            arry[writeIndex % arry.count] = element
            writeIndex += 1
            return true
        }else{
            return false
        }
    }
    
    public mutating func read() -> T? {
        
        if !isEmpty {
            let element = arry[readIndex % arry.count]
            readIndex += 1
            return element
        }else{
            return nil
        }
        
        
    }
    
    private var avaiableSpeaceForReading: Int {
        writeIndex - readIndex
    }
    
    public var isEmpty: Bool {
        avaiableSpeaceForReading == 0
    }
    
    private var avaiableSpeaceForWritng:Int{
        arry.count - avaiableSpeaceForReading
    }
    
    public var isFull: Bool {
        avaiableSpeaceForWritng == 0
    }
    
}
extension RingBuffer: CustomStringConvertible{
    public var description: String{
        let value = (0..<avaiableSpeaceForReading).map {
            String(describing: arry[($0 + readIndex) % arry.count]!)
        }
        return "[" + value.joined(separator: ", ") + "]"
    }
}
