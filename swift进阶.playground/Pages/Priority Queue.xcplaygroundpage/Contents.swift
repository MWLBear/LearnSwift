
/**
 
 队列只是使用先进先出（FIFO）顺序维护元素顺序的列表。 优先级队列是队列的另一种版本，在该队列中，不使用FIFO顺序，而是按优先级顺序将元素出队。 例如，优先级队列可以是：
 
 1.最大优先级，其中最前面的元素始终最大。
 2.最低优先级，其中最前面的元素始终是最小的。
 当您需要根据给定的元素列表确定最大值或最小值时，优先级队列特别有用
 
 
 */

struct PriorityQueue<Element: Equatable>: Queue {
    
    private var heap: Heap<Element>
    init(sort: @escaping (Element,Element) -> Bool,
         elements: [Element] = []) {
        heap = Heap(sort: sort, elements: elements)
    }
    // O(log n) .
    mutating func enqueue(_ element: Element) -> Bool {
        heap.insert(element)
        return true
    }
    // O(log n) .
    mutating func dequeue() -> Element? {
        heap.remove()
    }
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    var peek: Element? {
        heap.peek()
    }
    
}


var priorityQueue = PriorityQueue(sort: >, elements: [1,12,3,4,1,6,8,7])
while !priorityQueue.isEmpty {
    print(priorityQueue.dequeue()!)
}


//Challenge 1: Array-based priority queue

public struct PriorityQueueArray<T: Equatable> : Queue {
    private var elements: [T] = []
    let sort: (Element, Element) -> Bool
    
    public init(sort: @escaping (Element, Element) -> Bool,
                elments: [Element] = []) {
        self.sort = sort
        self.elements = elments
        self.elements.sort(by: sort)
    }
    
    public var isEmpty: Bool {
        elements.isEmpty
    }
    
    public var peek: T? {
        elements.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        for (index, otherElements) in elements.enumerated() {
            if sort(element, otherElements) {
                elements.insert(element, at: index)
                return true
            }
        }
        elements.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        isEmpty ? nil : elements.removeFirst()
    }
}

extension PriorityQueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: elements)
    }
}
print("\n")
print("Challenge 1: Array-based priority queue ")
var priorityQueue1 = PriorityQueueArray(sort: >, elments: [1,12,3,4,1,6,8,7])
priorityQueue1.enqueue(5)
priorityQueue1.enqueue(0)
priorityQueue1.enqueue(10)
print("queue:\(priorityQueue1)")
while !priorityQueue1.isEmpty {
    print(priorityQueue1.dequeue()!)
}

//Challenge 2: Prioritize a waitlist

public struct Person: Equatable {
    let name: String
    let age: Int
    let isMilitary: Bool
}

func tswiftSort(person1: Person,person2:Person) -> Bool {
    if person1.isMilitary == person2.isMilitary {
        return person1.age > person2.age
    }
    return person1.isMilitary
}

let p1 = Person(name: "Josh", age: 21, isMilitary: true)
let p2 = Person(name: "Jake", age: 22, isMilitary: true)
let p3 = Person(name: "Clay", age: 28, isMilitary: false)
let p4 = Person(name: "Cindy", age: 28, isMilitary: false)
let p5 = Person(name: "Sabrina", age: 30, isMilitary: false)


print("\n")
print("Challenge 2: Prioritize a waitlist")
let waitlist = [p1,p2,p3,p4,p5]
var priorityQueue2 = PriorityQueue(sort: tswiftSort, elements: waitlist)
while !priorityQueue2.isEmpty {
    print(priorityQueue2.dequeue()!)
}

//Challenge 3: Minimize recharge stops  最小充电桩问题

/**
 1.电动汽车具有无限的充电能力。
 2.一充电容量等于一英里。
 3.电台列表按距起始位置的距离排序：
 */

//充电站
struct ChargingStation {
    let distance: Int //距离起始点的位置
    let chargeCapacity: Int // 为汽车冲的电量,1度电=1公里
}

enum DestionationResult {
    case reachable(reachargeStop: Int)
    case unrechable
}

/**
 target:    行驶的目标
 startCharge:   开始的电量
 stations   冲电站有序列表(按照距离排序)
 
 */
func minRechargeStops(target: Int, startCharge: Int, stations:
                        [ChargingStation]) -> DestionationResult {
    guard startCharge <= target else {
        return .reachable(reachargeStop: 0)
    }
    var minStops = -1   //到达目标的最小停车次数
    var currentCharge = 0 //当前电量
    var currentStation = 0 //通过的站数
    
    //优先队列 为站点提供最高的充电量
    var chargePriority = PriorityQueue(sort: >, elements: [startCharge])
    
    while !chargePriority.isEmpty {
        guard let charge = chargePriority.dequeue() else {
            return .unrechable
        }
        currentCharge += charge
        minStops += 1
        if currentCharge >= target {
            return .reachable(reachargeStop: minStops)
        }
        //我们当前的充电无法到达目的地，但是我们还没有耗尽所有充电站，因此汽车的currentCharge可以到达下一个currentStation
        while currentStation < stations.count &&
                currentCharge >= stations[currentStation].distance{
            let distance = stations[currentStation].chargeCapacity
            _ = chargePriority.enqueue(distance)
            currentStation += 1
        }
    }

    return .unrechable
}

print("\n")
print("Challenge 3: Minimize recharge stops")
let stations = [
    ChargingStation(distance: 10, chargeCapacity:60),
    ChargingStation(distance: 20, chargeCapacity:10),
    ChargingStation(distance: 30, chargeCapacity:30),
    ChargingStation(distance: 60, chargeCapacity:20)]

let result = minRechargeStops(target: 100, startCharge: 10, stations:stations)
print(result)
