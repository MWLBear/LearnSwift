/**
 当此算法遍历数组时，它将数组划分为四个区域：
 1. a [low .. <i]包含所有元素<=枢轴。
 2. a [i ... j-1]包含所有元素>枢轴。
 3. a [j ... high-1]是您尚未比较的元素。
 4. a [high]是枢轴元素。
 
 
 */

public func partitionLomuto<T: Comparable>(_ a: inout [T],
                                           low: Int,
                                           high: Int) -> Int {
    let pivot = a[high]
    var i = low
    for j in low..<high {
        if a[j] <= pivot {
            a.swapAt(i, j)
            i += 1
        }
    }
    a.swapAt(i, high)//完成循环后，将i处的元素与枢轴交换。枢轴始终位于较小和较大的分区之间。
    return i
    
}

public func quicksortLomuto<T:Comparable>(_ a: inout [T],
                                          low: Int,
                                          high: Int) {
    if low < high {
        let pivot = partitionLomuto(&a, low: low, high: high)
        quicksortLomuto(&a, low: low, high: pivot-1)
        quicksortLomuto(&a, low: pivot+1, high: high)
    }
}
