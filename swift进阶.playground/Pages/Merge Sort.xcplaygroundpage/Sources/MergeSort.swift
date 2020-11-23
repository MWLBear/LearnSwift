
public func mergeSort<Element>(_ array: [Element])
    -> [Element] where Element: Comparable {
    
    guard array.count > 1 else {
        return array
    }
    //[7, 2, 6, 3, 9]
    let middle = array.count / 2
    let left = mergeSort(Array(array[..<middle]))
    let right = mergeSort(Array(array[middle...]))
    return  merge(left, right)
}

//Merge
private func merge<Element>(_ left: [Element],_ right: [Element])
    -> [Element] where Element: Comparable{
    var leftIndex = 0
    var rightIndex = 0
    var reslut: [Element] = []
    print("left:\(left)")
    print("right:\(right)")

    while leftIndex < left.count && rightIndex < right.count {
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        
        if leftElement < rightElement {
            reslut.append(leftElement)
            leftIndex += 1
        } else if leftElement > rightElement {
            reslut.append(rightElement)
            rightIndex += 1
        }else {
            reslut.append(leftElement)
            leftIndex += 1
            reslut.append(rightElement)
            rightIndex += 1
        }
    }
    
    if leftIndex < left.count {
        reslut.append(contentsOf: left[leftIndex...])
    }
    if rightIndex < right.count {
        reslut.append(contentsOf: right[rightIndex...])
    }
    print("reslut: \(reslut)")
    print("------------")

    return reslut
}
