import UIKit

/**
 self-balancing binary search tree: The AVL Tree.
 
 在AVL树中，任一节点对应的两棵子树的最大高度差为1，因此它也被称为高度平衡树。查找、插入和删除在平均和最坏情况下的时间复杂度都是{\displaystyle O(\log {n})}O(\log{n})。增加和删除元素的操作则可能需要借由一次或多次树旋转，以实现树的重新平衡。
 
 
 Perfect balance
 二叉搜索树的理想形式是完美平衡状态。 用技术术语来说，这意味着树的每个级别从上到下都充满了节点。
 不仅树是完全对称的，而且底层的节点也被完全填充。 这是完美平衡的要求。
 
 "Good-enough" balance
 平衡树的定义是必须填充树的每个级别（底部级别除外）。
 
 
 Unbalanced
 
 当树变得不平衡时，AVL树通过调整树的结构来保持平衡
 
 
  每个节点的左右子节点的高度最多必须相差1。这称为平衡因子。
 
 
 Rotations
 用于平衡二分搜索树的过程称为Rotations。
 These are known as left rotation, left-right rotation, right rotation and right-left rotation.
 
 
 
 关键点
 •自平衡树通过在添加或删除树中的元素时执行平衡过程来避免性能下降。
 •当树不再平衡时，AVL树通过重新调整树的部分来保持平衡。
 •通过在节点插入和删除上进行四种树旋转来实现平衡。
 
 */

example(of: "repeated insertions in sequence") {
    
    var tree = AVLTree<Int>()
    for i in 0..<15 {
        tree.insert(i)
        
    }
    print(tree)
    
}

example(of: "removing a value") {
    var tree = AVLTree<Int>()
    tree.insert(15)
    tree.insert(10)
    tree.insert(16)
    tree.insert(18)
    print(tree)
    tree.remove(10)
    print(tree)
}

//AVL Tree Challenges

//Challenge 1: Number of leaves

func leafNodes(inTreeOfHeight height: Int) -> Int {
    Int(pow(2.0,Double(height)))
}

//Challenge 2: Number of nodes
func nodes(inTreeOfHeight height: Int) -> Int {
    var totalHeight = 0
    for currentHeight in 0...height {
        totalHeight += Int(pow(2.0, Double(currentHeight)))
    }
    return totalHeight
}
//Challenge 3: A tree traversal protocol
protocol TraversableBinaryNode {
    associatedtype Element
    var value:Element { get }
    var leftChild: Self? { get }
    var rightChild: Self? { get }
    func traverseInOrder(visit: (Element) -> Void)
    func traversePreOrder(visit: (Element) -> Void)
    func traversePostOrder(visit: (Element) -> Void)
}

extension TraversableBinaryNode {
    func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
    
}

extension AVLNode: TraversableBinaryNode {}
example(of: "using TraversableBinaryNode") {
    var tree = AVLTree<Int>()
    for i in 0..<15 {
        tree.insert(i) }
    tree.root?.traverseInOrder { print($0) }
    
}


class 马娜娜{
    var 拖地:Bool!
    func eat(_ foot:String) -> String {
        if !拖地 {
            return "💩"
        }else{
            return "大盘🐤"
        }
    }
}
let mnn = 马娜娜()
mnn.拖地 = true
print(mnn.eat("大盘鸡"))
