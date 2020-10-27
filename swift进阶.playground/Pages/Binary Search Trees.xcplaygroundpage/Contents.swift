/**
A binary search tree, or BST, is a data structure that facilitates fast lookup, insert and removal operations
 二叉树搜索树或BST是一种数据结构，可促进快速查找，插入和删除操作
 
 •左子树的值必须小于其父子树值
 •右子树的值大于等于其父子树的值
 

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
