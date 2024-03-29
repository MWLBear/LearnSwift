public func quicksortNaive<T: Comparable>(_ a: [T]) -> [T]{
    guard a.count > 1 else {
        return a
    }
    let pivot = a[a.count / 2]
    let less = a.filter {$0 < pivot}
    let euqual = a.filter{$0 == pivot}
    let greater = a.filter{$0 > pivot}
    
    return quicksortNaive(less) + euqual + quicksortNaive(greater)

}
