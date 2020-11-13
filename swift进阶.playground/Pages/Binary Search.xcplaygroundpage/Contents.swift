
/**
 关键点
 •二进制搜索仅是对已排序集合的有效算法。
 •有时，对集合进行排序以仅利用二进制数据可能会有所益处
 查找元素的搜索能力。
 •序列上的firstIndex（of :)方法使用线性搜索，该搜索的时间复杂度为O（n）。 二进制搜索的时间复杂度为O（log n），如果您要进行重复查找，则对大型数据集的伸缩性会更好。
 
 
 */

let array = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150]

let range = array.startIndex ..< array.endIndex
print(range.lowerBound)
print(range.upperBound)

let size1 = array.distance(from: range.lowerBound, to: range.upperBound)
print(size1)

let search31 = array.firstIndex(of: 31)
let binarySearch31 = array.binarySearch(for: 31)
print("firstIndex(of:): \(String(describing: search31))")
print("binarySearch(for:): \(String(describing:binarySearch31))")


//Challenge 1: Binary search as a free function

func binarySearch<Elements:RandomAccessCollection>(
    for element: Elements.Element,
    in collection: Elements,
    in range: Range<Elements.Index>? = nil) -> Elements.Index?
    where Elements.Element: Comparable{
    
        let range = range ?? collection.startIndex..<collection.endIndex
        guard range.lowerBound < range.upperBound else {
            return nil
        }
        
        let size = collection.distance(from: range.lowerBound, to: range.upperBound)
        let middle = collection.index(range.lowerBound, offsetBy: size/2)
        
        if collection[middle] == element {
            return middle
        } else if collection[middle] > element {
            return binarySearch(for: element, in: collection, in: range.lowerBound..<middle)
        } else {
            return binarySearch(for: element, in: collection, in: collection.index(after: middle)..<range.upperBound)
        }
}

//Challenge 2: Searching for a range
// let array = [1, 2, 3, 3, 3, 4, 5, 5]
// findIndices(of: 3, in: array)
// 2..<5

//O(n)
func findIndices0(of value: Int, in arry: [Int]) -> Range<Int>? {
    guard let leftIndex = arry.firstIndex(of: value) else {
        return nil
    }
    guard let rightIndex = arry.lastIndex(of: value) else {
        return nil
    }
    return leftIndex..<rightIndex
}

func findIndices(of value: Int, in arry: [Int]) -> Range<Int>? {
    
    guard let startIndex = startIndex(of: value, in: arry, range: 0..<arry.count) else {
        return nil
    }
    guard let endIndex = endIndex(of: value, in: arry, range: 0..<arry.count) else {
        return nil
    }
    return startIndex..<endIndex
}


func startIndex(of value: Int,
                in arry: [Int],
                range: CountableRange<Int>) -> Int? {
    
    let middle = range.lowerBound + (range.upperBound - range.lowerBound) / 2
    if middle == 0 || middle == arry.count - 1 {
        if arry[middle] == value {
            return middle
        } else {
            return nil
        }
    }
    
    if arry[middle] == value {
        if arry[middle - 1] != value {
            return middle
        }else {
            return startIndex(of: value, in: arry, range: range.lowerBound..<middle)
        }
    }else if value < arry[middle] {
        return startIndex(of: value, in: arry, range: range.lowerBound..<middle)
    }else {
        return startIndex(of: value, in: arry, range: middle..<range.upperBound)
    }
}


func endIndex(of value: Int,
              in arry: [Int],
              range: CountableRange<Int>) -> Int? {
    
    let middleIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
    
    if middleIndex == 0 || middleIndex == arry.count - 1 {
        if arry[middleIndex] == value {
            return middleIndex
        }else {
            return nil
        }
    }
    
    if arry[middleIndex] == value {
        if arry[middleIndex + 1] != value {
            return middleIndex + 1
        }else {
           return endIndex(of: value, in: arry, range: middleIndex..<range.upperBound)
        }
    } else if value < arry[middleIndex] {
        return endIndex(of: value, in: arry, range: range.lowerBound..<middleIndex)
    } else {
        return endIndex(of: value, in: arry, range: middleIndex..<range.upperBound)
    }
}

let array1 = [1, 2, 3, 3, 3, 4, 5, 5]
if let indices = findIndices(of: 3, in: array1) {
  print(indices)
}
