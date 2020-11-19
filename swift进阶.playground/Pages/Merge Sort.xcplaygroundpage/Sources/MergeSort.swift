public func mergeSort<Element>(_ array: [Element])
    -> [Element] where Element: Comparable {
    
    guard array.count > 1 else {
        return array
    }
    let middle = array.count / 2
    let left = mergeSort(Array(array[..<middle]))
    let right = mergeSort(Array(array[middle...]))
    
    return merge(left, right)
}
private func merge<Element>(_ left: [Element],_ right: [Element])
    -> [Element] where Element: Comparable{
    
    
    return left
}
