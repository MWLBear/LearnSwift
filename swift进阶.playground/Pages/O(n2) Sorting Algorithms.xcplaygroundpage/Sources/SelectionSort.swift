/**
 选择排序
 选择排序遵循冒泡排序的基本思想，但是通过减少swapAt操作的数量对该选择算法进行了改进。 选择排序只会在每次通过结束时交换
 
 
 把最小的交换到最前面,比较剩余的没有排序的找到最小的依次放置
 */
//public func selectionSort<Elemnet>(_ arry: inout [Elemnet])
//where Elemnet: Comparable {
//    guard arry.count >= 2 else {
//        return
//    }
//    //[9, 4, 10, 3]
//
//    for current in 0..<(arry.count-1) {
//        var lowest = current
//
//        for other in (current + 1)..<arry.count {
//            if arry[lowest] > arry[other] { //找到最小值
//                lowest = other
//            }
//        }
//        if lowest != current {
//            arry.swapAt(lowest, current)
//        }
//    }
//}
//


public func selectionSort<T>(_ collection: inout T)
where T: MutableCollection, T.Element: Comparable {
    
    guard collection.count >= 2 else {
        return
    }
    for current in collection.indices {
        var lowest = current
        var other = collection.index(after: current)
        
        while other < collection.endIndex {
            if collection[lowest] > collection[other]{
                lowest = other
            }
            other = collection.index(after: other)
        }
        if lowest != current {
            collection.swapAt(lowest, current)
        }
    }
    
}
