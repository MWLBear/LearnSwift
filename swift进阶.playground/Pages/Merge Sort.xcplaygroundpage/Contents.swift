/**
 
 合并排序是最有效的排序算法之一。
 时间复杂度为O（n log n），是所有通用排序算法中最快的算法之一。 合并排序的思想是分而治之-将一个大问题分解为几个较小的，更易于解决的问题，然后将这些解决方案组合为最终结果。 合并排序的原则是先拆分然后合并。
 
 
 
 */

example(of: "merge sort") {
    let array = [7,2,6,3,9]
    let middle = array.count / 2
    print(middle)
    print(Array(array[..<middle]))
    
    print("original :\(array)")
    print("merge sorted: \(mergeSort(array))")
    
}

//Challenge 1: Speeding up appends
//Consider the following code:

example(of: "challenge 1") {
    let size = 1024
    var values: [Int] = []
    values.reserveCapacity(size)
    
    for i in 0..<size {
        values.append(i)
    }
}

//Challenge 2: Merge two sequences
func merge<T: Sequence>(first: T, second:T)
    ->AnySequence<T.Element> where T.Element: Comparable {
    var result: [T.Element] = []
    var firstIterator = first.makeIterator()
    var secondIterator = second.makeIterator()
    
    var firstNextValue = firstIterator.next()
    var secodeNextValue = secondIterator.next()
    
    while let first = firstNextValue,let second = secodeNextValue {
        if first < second {
            result.append(first)
            firstNextValue = firstIterator.next()
        } else if second < first {
            result.append(second)
            secodeNextValue = secondIterator.next()
        }else {
            result.append(first)
            result.append(second)
            firstNextValue = firstIterator.next()
            secodeNextValue = secondIterator.next()
        }
    }
    
    while let first = firstNextValue {
        result.append(first)
        firstNextValue = firstIterator.next()
    }
    while let second = secodeNextValue{
        result.append(second)
        secodeNextValue = secondIterator.next()
    }
    
    return AnySequence<T.Element>(result)
}

example(of: "challenge") {
    let array1 = [1,2,3,4,5,6,7,8]
    let array2 = [1,3,4,5,5,6,7,7]
    
    for element in merge(first: array1, second: array2) {
        print(element)
    }
    
}
