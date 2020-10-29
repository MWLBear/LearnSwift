/**
A binary search tree, or BST, is a data structure that facilitates fast lookup, insert and removal operations
 二叉树搜索树或BST是一种数据结构，可促进快速查找，插入和删除操作
 排序二叉树
 
 •左子树的值必须小于其父子树值
 •右子树的值大于等于其父子树的值
 

 •二进制搜索树是用于保存已排序数据的强大数据结构。
 •二进制搜索树的元素必须具有可比性。 这可以通过使用
 通用约束或通过提供闭包进行比较。
 •在BST中插入，删除和包含方法的时间复杂度为O（log
 n）。
 •由于树变得不平衡，性能将降低到O（n）
 AVL树的自平衡二进制搜索树
 
 */

example(of: "building a BST") {
    var bst = BinarySearchTree<Int>()
    for i in 0..<5 {
        bst.insert(i)
    }
    print(bst)

}
var exampleTree:BinarySearchTree<Int> {
    var bst = BinarySearchTree<Int>()
    bst.insert(3)
    bst.insert(1)
    bst.insert(4)
    bst.insert(0)
    bst.insert(2)
    bst.insert(5)
    
    return bst
}

example(of: "building a BST") {
    print(exampleTree)
}

example(of: "finding a node") {
    if exampleTree.contains(5) {
        print("Found 5!")
    }else {
        print("Colund not found 5")
    }
}

example(of: "removing a node") {
    var tree = exampleTree
    print("Tree before removal:")
    print(tree)
    tree.remove(3)
    print("Tree after removing root:")
    print(tree)
}

//Binary Search Tree Challenges

//Challenge 1: Binary tree or binary search tree?

extension BinaryNode where Element: Comparable {
    var isBinarySearchTree: Bool {
        isBST(self, min: nil, max: nil)
    }
    
    private func isBST(_ tree: BinaryNode<Element>?,
                       min: Element?,
                       max: Element?) -> Bool {
        guard let tree = tree else {
            return true
        }
        
        if let min = min, tree.value <= min {
            return false
        } else if let max = max, tree.value >= max {
            return false
        }
        return isBST(tree.leftChild, min: min, max: tree.value) &&
        isBST(tree.rightChild, min: tree.value, max: max)
    }
}
//Challenge 2: Equatable
extension BinarySearchTree: Equatable {
    public static func == (lhs: BinarySearchTree, rhs: BinarySearchTree) -> Bool {
        isEqual(lhs.root, rhs.root)
    }
    
    private static func isEqual<Element: Equatable>(
        _ node1: BinaryNode<Element>?,
        _ node2: BinaryNode<Element>?) -> Bool {
        
        guard let leftNode = node1,
            let rightNode = node2 else {
            return node1 == nil && node2 == nil
        }
        return leftNode.value == rightNode.value &&
            isEqual(leftNode.leftChild, rightNode.rightChild) &&
            isEqual(leftNode.rightChild, rightNode.leftChild)
        
    }
  
}

//Challenge 3: Is it a subtree?
extension BinarySearchTree where Element: Hashable {
    public func contains(_ subtree: BinarySearchTree) -> Bool {
        var set: Set<Element> = []
        root?.traverseInOrder(visit: {
            set.insert($0)
        })
        var isEqual = true
        
        subtree.root?.traverseInOrder(visit: {
            isEqual = isEqual && set.contains($0)
        })
        return isEqual
    }
}
