import Foundation
//冒泡排序
//如果已经进行排序，气泡排序的最佳时间复杂度为O（n），而最差的平均时间复杂度为O（n2)

//第一次循环 最大的放在最后面
//public func bubbleSort<Element>(_ arry: inout [Element])
//    where Element: Comparable {
//    guard arry.count >= 2 else {
//        return
//    }
//
//    for end in (1..<arry.count).reversed() {
//
//        var swapped = false
//        for current in 0..<end {
//            if arry[current] > arry[current + 1] {
//                arry.swapAt(current, current + 1)
//                swapped = true
//            }
//        }
//        if !swapped {
//            return
//        }
//    }
//}
//

public func bubbleSort<T>(_ collection: inout T)
    where T: MutableCollection, T.Element: Comparable {
    guard collection.count >= 2 else {
        return
    }
    /**
     end: 3
     current: 1
     current: 2
     current: 3
     end: 2
     current: 1
     current: 2
     end: 1
     current: 1
     
     */
    
    for end in collection.indices.reversed() {
        
        print("end: \(end)")
        var swapped = false
        var current = collection.startIndex
        while current < end {
            let next = collection.index(after: current)
            if collection[current] > collection[next] {
                collection.swapAt(current, next)
                swapped = true
            }
            current = next
            print("current: \(current)")
        }
        if !swapped {
            return
        }
    }
}
