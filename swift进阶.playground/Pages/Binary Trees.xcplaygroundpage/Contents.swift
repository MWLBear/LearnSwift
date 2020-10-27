/**
 
 二叉树是其中每个节点最多具有两个子代的树，通常称为左子代和右子代：
 
 
 
 */

var tree : BinaryNode<Int> = {
    
    let zero = BinaryNode(value: 0)
    let one = BinaryNode(value: 1)
    let five = BinaryNode(value: 5)
    let seven = BinaryNode(value: 7)
    let eight = BinaryNode(value: 8)
    let nine = BinaryNode(value: 9)
    
    seven.leftChild = one
    one.leftChild = zero
    one.rightChild = five
    seven.rightChild = nine
    nine.leftChild = eight
    
    return seven
}()

print(tree)

example(of: "in-order traversal") {
    tree.traverseInOrder { print($0) }
    
}

example(of: "pre-order traversal") {
    tree.traversePreOrder {
        print($0)
    }
}
example(of: "post-order traversal") {
    tree.traversePostOrder { print($0) }
}


//Challenge 1: Height of a Tree
//给定二叉树，找到树的高度。 二叉树的高度取决于根与最远的叶子之间的距离。
// 具有单个节点的二叉树的高度为零，因为单个节点既是根又是最远的叶。

func heigth<T>(of node: BinaryNode<T>?) -> Int {
    guard let node = node else {
        return -1
    }
    
    return 1 + max(heigth(of: node.leftChild), heigth(of: node.rightChild))
}

example(of: "tree depth") {
    print(heigth(of: tree))
}

//Challenge 2: Serialization

extension BinaryNode {
    public func traversePreOrder1(visit: (Element?) -> Void) {
        visit(value)
        if let leftChild = leftChild {
            leftChild.traversePreOrder1(visit: visit)
        }else{
            visit(nil)
        }
        if let rightChild = rightChild {
            rightChild.traversePreOrder1(visit: visit)
        }else{
            visit(nil)
        }
    }
}

func serialize<T>(_ node: BinaryNode<T>) -> [T?] {
    var arry: [T?] = []
    node.traversePreOrder1 {arry.append($0)}
    return arry
}


func deserizlize<T>(_ arry: [T?]) -> BinaryNode<T>? {
    var reversed = Array(arry.reversed())
    return deserialize(&reversed)
}
//[15, 10, 5, nil, nil, 12, nil, nil, 25, 17, nil, nil, nil]
func deserialize<T>(_ arry: inout [T?])
    -> BinaryNode<T>? {
        
        guard !arry.isEmpty,let value = arry.removeLast() else {
            return nil
        }
        
        let node = BinaryNode(value: value)
        node.leftChild = deserialize(&arry)
        node.rightChild = deserialize(&arry)
        return node
}


func funA(){
    funB()
    print("funA")
}
func funB(){
    funC()
    print("funB")
}
func funC(){
    print("funC")
}


funA()

/*
 
funC
funB
funA -> top
 
每次调用一次函数，都是等它彻底执行完毕之后，才会返回去继续执行
*/

var array = serialize(tree)
//var array = [15, 10, 5, nil, nil, 12, nil, nil, 25, 17, nil, nil, nil]
let node = deserizlize(array)
print(node!)
