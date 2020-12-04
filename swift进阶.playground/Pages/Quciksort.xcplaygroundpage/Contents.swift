
var list = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortLomuto(&list, low: 0, high: list.count-1)
print(list)
print("----------")

var list2 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortHoare(&list2, low: 0, high: list2.count-1)
print(list2)
print("----------")

var list3 = [8,3,9,2,7]
   // [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quickSortMedian(&list3, low: 0, high: list3.count - 1)
print(list3)
print("----------")

var list4 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortDutchFlag(&list4, low: 0, high: list4.count - 1)
print(list4)

//Challenge 1

public func quicksortIterativeLomuto<T: Comparable>(_ a: inout [T],
                                                    low: Int,high: Int) {
    var stack = Stack<Int>()
    stack.push(low)
    stack.push(high)
    
    while !stack.isEmpty {
        guard let end = stack.pop(),
              let start = stack.pop() else {
            continue
        }
        let p = partitionLomuto(&a, low: start, high: end)
        if (p - 1) > start {
            stack.push(start)
            stack.push(p - 1)
        }
        if (p+1) < end {
            stack.push(p + 1)
            stack.push(end)
        }
    }
    
}
print("----------")
var list5 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortIterativeLomuto(&list5, low: 0, high: list5.count - 1)
print(list5)

//challenge 2
/**
 挑战2的解决方案
 •需要稳定性时，合并排序优于快速排序。 合并排序是一种稳定的排序，可以保证O（n log n）。 快速排序不是这种情况，它不稳定且性能可能与O（n2）一样差。
 •合并排序对于较大的数据结构或元素分散在整个内存中的数据结构更有效。 当元素存储在连续块中时，快速排序效果最佳。
 
 */
print("----------")

//challenge 3
var numbers1 = [30, 40, 20, 30, 30, 60, 10]
let p = numbers1.partition(by: {$0 > 30})
print("numbers1: \(numbers1)")
print("p: \(p)")
print(numbers1.index(before: p))
print(numbers1.index(after: p))

let head = numbers1.prefix(upTo: p)
let end = numbers1.suffix(from: p)
print(head)
print(end)

print("----------")

extension MutableCollection where Self: BidirectionalCollection, Element: Comparable {
    mutating func quicksort() {
        quicksortLumuto(low: startIndex, high: index(before: endIndex))
    }
    private mutating func quicksortLumuto(low: Index, high: Index) {
        if low <= high {
            let pivotValue = self[high]
            var p = self.partition(by: {$0 > pivotValue})
            if p == endIndex {
                p = index(before: p)
            }
            self[..<p].quicksortLumuto(low: low, high: index(before: p))
            self[p...].quicksortLumuto(low: index(after: p), high: high)
        }
    }
}

var numbers = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
numbers.quicksort()
print(numbers)

