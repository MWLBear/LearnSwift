import Foundation

/**
 时间复杂度
 Time complexity is a measure of the time required to run an algorithm as the input size increases
 时间复杂度是输入大小增加时运行算法所需时间的度量
 
 Constant time  恒定时间 O(1)
 A constant time algorithm is one that has the same running time regardless of the size of the input.
 恒定时间算法是一种具有相同运行时间的算法，无论输入大小如何。
 
 Linear time 线性时间   The Big O -------  O(n)
 As the amount of data increases, the running time increases by the same amount.
 
 
 Quadratic time   O(n2)
 this time complexity refers to an algorithm that takes time proportional to the square of the input size.
 
 
 
 
 Logarithmic time 对数时间
 An algorithm that can repeatedly drop half of the required comparisons will have logarithmic time complexity

 
 
 Quasilinear time
 
 
 Space complexity  空间复杂度
 
 
 
 
 */



//Linear time
func printNames(names:[String]){
    for name in names {
        print(name)
    }
}


//Quadratic time
func printNames1(names: [String]) {
    
    for _ in names {
        for name in names {
            print(name)
        }
    }
}
//Logarithmic time
let numbers = [1, 3, 56, 66, 68, 80, 99, 105, 450]

func naiveContains(_ value:Int, in arry:[Int])->Bool{
    
    for element in arry {
        if element == value {
            return true
        }
    }
    return false
}

func naiveContains1(_ value:Int, in arry:[Int])->Bool{
    
    guard !arry.isEmpty else{return false}
    
    let middleIndex = arry.count/2
    
    if value <= arry[middleIndex]{
        
        for index in 0..<middleIndex{
            if arry[index] == value {
                return true
            }
        }
    }else{
        for index in middleIndex..<arry.count{
            if arry[index] == value {
                return true
            }
        }
    }
    return false
}



//Space complexity

//空间复杂度 O(n)

func printfSorted(_ arry:[Int]){
    let sorted = arry.sorted()
    for element in sorted{
        print(element)
    }
}

func printfSorted1(_ arry:[Int]){

    guard !arry.isEmpty else { return }
    var currentCount = 0
    var minValue = Int.min
    
    for value in arry{
        if value == minValue{
            print(value)
            currentCount += 1
        }
    }
    while currentCount<arry.count {
        var currentValue = arry.max()!
        
        for value in arry {
            if value<currentValue && value>minValue {
                currentValue = value
            }
        }
        var printCount = 0
        
        for value in arry {
            if value == currentValue{
                print(value)
                currentCount += 1
            }
        }
        
        minValue = currentValue
        
    }
    
    
}
