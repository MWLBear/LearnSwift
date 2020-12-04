public func medianOfThree<T: Comparable>(_ a: inout [T],
                                         low: Int,
                                         high: Int) -> Int {
    //[8,3,9,2,7]
    
    let center = (low+high) / 2
    if a[low]>a[center] {
        a.swapAt(low, center)
    }
    print("a0:\(a)")
    if a[low] > a[high] {
        a.swapAt(low, high)
    }
    print("a1:\(a)")

    if a[center] > a[high] {
        a.swapAt(center, high)
    }
    print("a2:\(a)")

    return center
}

public func quickSortMedian<T: Comparable>(_ a: inout [T],
                                           low: Int,
                                           high: Int) {
    if low < high {
        let pivotIndex = medianOfThree(&a, low: low, high: high)
        print("pivotIndex:\(pivotIndex)")
        a.swapAt(pivotIndex, high)
        print("a3:\(a)")
        let pivot = partitionLomuto(&a, low: low, high: high)
        quicksortLomuto(&a, low: low, high: pivot-1)
        quicksortLomuto(&a, low: pivot+1, high: high)
    }
}
