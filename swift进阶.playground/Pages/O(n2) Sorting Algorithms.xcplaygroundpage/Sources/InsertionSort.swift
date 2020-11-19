/**
 
 插入排序是一种更有用的算法。 像冒泡排序和选择排序一样，插入排序的平均时间复杂度为O（n2），
 但是插入排序的性能可能会有所不同。 已排序的数据越多，所需的工作就越少。 如果数据已经排序，则插入排序的最佳时间复杂度为O（n）。
 Swift标准库排序算法使用混合排序方法，其中插入排序用于较小（<20个元素）的未排序分区。
 
 
 */

//public func insertionSort<Element>(_ array: inout [Element])
//    where Element: Comparable {
//    guard array.count >= 2 else {
//        return
//    }
//    //[9, 4, 10, 3] (1...3)
//    for current in 1..<array.count {
//        print("current: \(current)")
//
//        for shifting in (1...current).reversed() { // [4,9,10,3]
//            if array[shifting] < array[shifting - 1] { //后面小于前面交换
//                array.swapAt(shifting, shifting - 1)
//            }else {
//                break
//            }
//        }
//    }
//}


//BidirectionalCollection 支持向后和向前遍历的集合。
/**
 它们分别是：

 BidirectionalCollection：可以向前和向后遍历的集合。比如 [String.CharacterView] (https://developer.apple.com/reference/swift/string.characterview)。（虽然在 characters 集合上你不能高效地跳转到任意位置（因为字形集群是变长的），但是指定下标依旧可以找到对应的 Character。）
 RandomAccessCollection：可以在常量时间访问任何元素的集合。Array 就是一个规范的例子。
 MutableCollection：支持集合通过下标的方式改变自身的元素，即 array[index] = newValue。
 RangeReplaceableCollection：支持插入和删除任意区间的元素集合。
 
 */

public func insertionSort<T>(_ collection: inout T)
    where T: BidirectionalCollection & MutableCollection, T.Element: Comparable {
    
    guard collection.count >= 2 else {
        return
    }
    
    for current in collection.indices {
        var shifting = current
        while shifting > collection.startIndex {
            let previous = collection.index(before: shifting)
            if collection[shifting] < collection[previous] {
                collection.swapAt(shifting, previous)
            }else {
                break
            }
            shifting = previous
        }
    }
}
