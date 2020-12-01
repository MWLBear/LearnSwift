import Foundation
/**
 基数排序
 least significant digit (LSD)
 
 */


example(of: "radix sort") {
    print(88 % 10)
    print("------")
    var array = [88, 410, 1772, 20]
    print("Original array: \(array)")
    array.radixSort()
    print("Radix sorted: \(array)")
    
   
}

//Challenge 1: Most significant digit

extension Int {
    var digits: Int { //位数
        var count = 0
        var num = self
        while num != 0 {
            count += 1
            num /= 10
        }
        return count
    }
    func digt(atPostion postion: Int) -> Int? {
        guard postion < digits else {
            return nil
        }
        var num = self //123
        let correctedPostion = Double(postion + 1)

        while num / Int(pow(10.0, correctedPostion)) != 0 {
            num /= 10
        }
        return num % 10
    }
}

extension Array where Element == Int {
    
    private var maxDigits: Int {
        self.max()?.digits ?? 0
    }
    
    mutating func lexicographicalSort() {
        self = msdRadixSorted(self, 0)
    }
    
    private func msdRadixSorted(_ arry: [Int], _ position: Int) -> [Int] {
        
        
        guard position < arry.maxDigits else {
            return arry
        }
        
        var buckets: [[Int]] = .init(repeating: [], count: 10)
        var priorityBucket: [Int] = []
        
        arry.forEach { number in
            print("number: \(number)")
            guard let dight = number.digt(atPostion: position) else {
                priorityBucket.append(number)
               
                return
            }
            buckets[dight].append(number)
        }
        print("buckets: \(buckets)")

        priorityBucket.append(contentsOf: buckets.reduce(into: []){ result, bucket in
            guard !bucket.isEmpty else {
                return
            }
            result.append(contentsOf: msdRadixSorted(bucket, position + 1))
        })
        print("priorityBucket: \(priorityBucket)")

        return priorityBucket
    }
}

example(of: "digt") {
    let num = 12
    print(num.digits)

//    let array = [[],[121],[123],[222],[3],[4],[],[]]
//    array.reduce(into: []) { (reslut, bucket) in
//        print("reslut: \(reslut)")
//        print("bucket: \(bucket)")
//    }
//    print("array :\(array)")
    
    var array1 = [500, 1345, 13, 459, 44, 999]
    array1.lexicographicalSort()
    print(array1) // outputs [13, 1345, 44, 459, 500, 999]
    
    var array: [Int] = (0...10).map{_ in Int(arc4random())}
    array.lexicographicalSort()
    print(array)
}



