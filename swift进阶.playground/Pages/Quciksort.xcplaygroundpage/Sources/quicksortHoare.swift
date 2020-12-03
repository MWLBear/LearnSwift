public func partitionHoare<T: Comparable>(_ a: inout [T],
                                          low: Int,
                                          high: Int) -> Int {
    let pivot = a[low]
    var i = low - 1
    var j = high + 1
    
    //[5,3,8]
    while true {
        print("pivot:\(pivot)")
        print("i:\(i)")
        print("j:\(j)")
        repeat { j -= 1} while a[j] > pivot
        repeat {i += 1} while a[i] < pivot
        
        if i < j {
            a.swapAt(i, j)
            print("array:\(a)")
        }else {
            return j
        }
    }
    
    
}
