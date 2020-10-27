//: [Previous](@previous)

import Foundation

//用数组实现栈


struct Stack{
    
    var stack:[AnyObject]
    var isEmpty:Bool {return stack.isEmpty}
    var peek:AnyObject?{return stack.last}
    
    init() {
        stack = [AnyObject]()
    }
    
    mutating func push(object:AnyObject) {
        stack.append(object)
    }
    
    mutating func pop()->AnyObject? {
        if !isEmpty{
            return stack.removeLast()
        }else{
            return nil
        }
    }
    
}


//给一个整型数组和一个目标值，判断数组中是否有两个数字之和等于目标值

//O(n^2)
func twoSum(nums: [Int], _ target: Int) -> Bool{
    
    
    for i in 0..<nums.count-1{
        
        for j in i..<nums.count-1{
            
            let sum = nums[i]+nums[j+1]
            
            if sum == target{
                
                return true
            }

        }
    }
    
    return false
}
//2,4,6,5,8
/**
 0+1 0+2 0+3
 1+2 1+3
 2+3
 
 */

twoSum(nums: [2,2,3,5], 4)

//O(n)
func twoSum1(nums: [Int], _ target: Int) -> Bool {

    var set = Set<Int>()
    
    for num in nums{
        
        if set.contains(target-num) {
            return true
        }
        
        set.insert(num)
    }
    
    return false
}

//给定一个整型数组中有且仅有两个数字之和等于目标值，求两个数字在数组中的序号

func twoSum2(nums: [Int], _ target: Int) -> [Int] {
    
    var dict = [Int:Int]()
    
    for (i,num) in nums.enumerated(){
        
        //i=2,num=3
        if let lasIndex = dict[target-num]{
            print(lasIndex)
            return [lasIndex,i]
        }else{
            dict[num] = i
        }
        
       /**
        [
         [1:0],
         [2:1],
         [3:2]
         ]
         
         */
    }
   
    fatalError("No valid output!")
}

twoSum2(nums: [1,2,3], 4)

let str = "apple"
// 访问字符串中的单个字符，时间复杂度为O(1)
let char = str[str.index(str.startIndex, offsetBy: 1)]


//字符串的翻转

fileprivate func _reverse<T>(_ chars:inout [T],_ start:Int,_ end:Int){
    var start = start,end = end
    while start<end {
        swap(&chars, start, end)
        start += 1
        end -= 1
    }
}

fileprivate func swap<T>(_ chars:inout[T],_ p:Int,_ q:Int){
    (chars[p], chars[q]) = (chars[q], chars[p])
}

var apple = ["a","p","p","l","e"]

//整个字符串翻转，"the sky is blue" -> "eulb si yks eht"
//每个单词作为一个字符串单独翻转，"eulb si yks eht" -> "blue is sky the"

func reverseWords(s:String?)->String?{
    
    guard let s = s else { return nil}
    var chars = Array(s),start = 0
    _reverse(&chars, 0, chars.count-1)
    print("chars:\(chars)")
    
    for i in 0..<chars.count{
        if i == chars.count-1 || chars[i+1] == " "{
            _reverse(&chars, start, i)
            start = i + 2
        }
    }
    return String(chars)
}


func reverseWords1(s: String?) -> String? {
    
    guard let s = s else { return nil}

    //翻转整体字符串
    let chars4 = String(s.reversed())
    print(chars4)
    
    var startIdx = s.startIndex, endIdex = s.endIndex
    
    var result = String()

    //逐个单词进行翻转，然后拼接
    while let comma = chars4[startIdx..<endIdex].index(of: " ") {
        
        result.append(String(chars4[startIdx..<comma].reversed()) + " ")
        startIdx = chars4.index(after: comma)
    }
    result.append(String(chars4[startIdx..<endIdex].reversed()))
    
    print(result)
    
    return String(result)
}
var rev = reverseWords1(s: "the sky is blue")
print(rev!)



//单向链表

//单向节点
class ListNode{
    var val:Int
    var next:ListNode?

    init(_ val:Int) {
        self.val = val
        self.next = nil
    }
}
//
class List{
    
    var head:ListNode? //头
    var tail:ListNode? //尾
    
    var isEmpty:Bool{
        return head == nil
    }
    
    var first:ListNode?{
        return head
    }
    var last:ListNode?{
        return tail
    }
    
    //添加元素
    func append(_ value:Int) {
        
        let newNode = ListNode(value)
        
        if let tailNode = tail { //链表有节点
            tailNode.next = newNode
        }else{
            head = newNode
        }
        
        tail = newNode
    }
    
    func removeAll() {
        head = nil
        tail = nil
    }
    
    //1,2,3,4,5
//    func remove(_ node:ListNode) -> Int {
//
//        let next = node.next
//
//        if next == nil { //最后一个节点
//
//        }
//
//    }
    
    //访问节点
    func nodeAt(_ index:Int) -> ListNode? {
        
        if index >= 0 {
            var node = head
            var i = index
            
            while node != nil {
                if i == 0 {return node}
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    
    //尾插法
    func appendToTail(_ val:Int) {
        
        if tail == nil {
            tail = ListNode(val)
            head = tail
        }else{
            tail!.next = ListNode(val)
            tail = tail!.next
        }
    }
    
    //头插法
    func appendToHead(_ val:Int) {
        if head == nil{
            head = ListNode(val)
            tail = head
        }else{
            let temp = ListNode(val)
            temp.next = head
            head = temp
        }
    }
}


extension List:CustomStringConvertible{
    var description: String{
        var text = "["
        var node = head
        
        while node != nil {
            text += "\(node!.val)"
            node = node!.next
            if node != nil {
                text += ", "
            }
        }
        return text + "]"
    }
}

func enumNode(_ head:ListNode?){
    var node = head
    
    while node != nil {
       
        print("lisNode:\(node!.val)")
        
        node = node!.next
    }
    
}

//给一个链表和一个值x，要求将链表中所有小于x的值放到左边，所有大于等于x的值放到右边。原链表的节点顺序不能变。

func partition(_ head:ListNode?,_ x:Int)->ListNode?{
    
    let prevDummy = ListNode(-1)
    var prev = prevDummy
    
    let postDummy = ListNode(-1)
    var post = postDummy
    
    var node = head
    
    while node != nil {

        if node!.val < x {
            prev.next = node
            prev = node!
        }else{
            post.next = node
            post = node!
        }
        node = node!.next
    }
    //左边的尾节点指向右边的头结点即可
    post.next = nil
    prev.next = postDummy.next
    return prevDummy.next
    
}
//Dummy节点，它的作用就是作为一个虚拟的头前结点。我们引入它的原因是我们不知道要返回的新链表的头结点是哪一个，它有可能是原链表的第一个节点，可能在原链表的中间，也可能在最后，甚至可能不存在（nil

func getLeftList(_ head: ListNode?, _ x: Int) -> ListNode? {
    let dummy = ListNode(0)
    var pre = dummy
    var node = head
    
    while node != nil {
        
        //[1, 5, 3, 2, 4, 2]
        
        if node!.val < x {
            pre.next = node
            pre = node!
        }
        node = node!.next
    }
    
    node?.next = nil
    return dummy.next
}


let list = List()
list.append(1)
list.append(5)
list.append(3)
list.append(2)
list.append(4)
list.append(2)

print(list)

//var leftlist = getLeftList(list.head, 3)
var partlist = partition(list.head, 3)
//print(partlist)

//enumNode(partlist)

//快行指针
func hasCycle(_ head:ListNode?)->Bool{
    var slow = head
    var fast = head
    
    while fast != nil && fast!.next != nil {
        slow = slow!.next
        fast = fast!.next!.next
        
        if slow === fast {
            return true
        }
    }
    return false
}

//删除链表中倒数第n个节点。例：1->2->3->4->5，n = 2。返回1->2->3->5。
//注意：给定n的长度小于等于链表的长度。

func removeNthFromEnd(head:ListNode?,_ n:Int)->ListNode?{
   
    guard let head = head else {return nil}
    
    let dummy = ListNode(0)
    dummy.next = head
    var prev:ListNode? = dummy
    var post:ListNode? = dummy
    
    //第一个指针（指向头结点之前）就落后第二个指针n个节点。
    
    
    // 设置后一个节点初始位置
    for _ in 0 ..< n{
        if post == nil {
            break
        }
        post = post!.next
    }
    print("post:\(post!.val)")
    // 同时移动前后节点
    while post != nil && post!.next != nil {
        prev = prev!.next
        post = post!.next
    }
    // 删除节点
    prev!.next = prev!.next!.next
    
    return dummy.next
}

var list1 = List()
list1.append(1)
list1.append(2)
list1.append(3)
list1.append(4)
list1.append(5)

enumNode(removeNthFromEnd(head: list1.head, 2))

