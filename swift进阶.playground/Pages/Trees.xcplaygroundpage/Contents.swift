import Foundation
/**
 Node
 像链表一样，树由节点组成。
 
 Parent and child
 每个节点（最顶层的节点除外）都恰好连接到其上方的一个节点。 该节点称为父节点。 直接在其下方并与其连接的节点称为其子节点。 在树上，每个孩子只有一个父母。 那就是造出一棵树的原因。
 
 Root
 树中最顶层的节点称为树的根。 它是唯一没有父节点的节点
 
 Leaf
 如果节点没有子节点，则为叶子：
 
 
 关键点
 •树与链接列表具有一些相似之处，但是，链接列表节点只能链接到一个后继节点，而树节点可以链接到许多子节点。
 •除根节点外，每个树节点都只有一个父节点。
 •根节点没有父节点。
 •叶节点没有子节点。
 •熟悉树的术语，例如父母，孩子，叶子和根。 这些术语中有许多是其他程序员常用的语言，将用于帮助解释其他树形结构。
 •遍历（例如深度优先遍历和级别顺序遍历）不是特定于常规树的。 它们也可以在其他树上工作，尽管根据树的结构，它们的实现会略有不同。
 
 */

example(of: "creating a tree") {
    let beverages = TreeNode("Beverages")
    
    let hot = TreeNode("Hot")
    let cold = TreeNode("Cold")

    beverages.add(hot)
    beverages.add(cold)
}

func makeBeverageTree() -> TreeNode<String> {
    let tree = TreeNode("Beverages")
    let hot = TreeNode("hot")
    let cold = TreeNode("cold")
    let tea = TreeNode("tea")
    let coffee = TreeNode("coffee")
    let chocolate = TreeNode("cocoa")
    let blackTea = TreeNode("black")
    let greenTea = TreeNode("green")
    let chaiTea = TreeNode("chai")
    let soda = TreeNode("soda")
    let milk = TreeNode("milk")
    let gingerAle = TreeNode("ginger ale")
    let bitterLemon = TreeNode("bitter lemon")
    
    tree.add(hot)
    tree.add(cold)
    hot.add(tea)
    hot.add(coffee)
    hot.add(chocolate)
    cold.add(soda)
    cold.add(milk)
    tea.add(blackTea)
    tea.add(greenTea)
    tea.add(chaiTea)
    soda.add(gingerAle)
    soda.add(bitterLemon)
    
    
    return tree
}
example(of: "depth-first traversal") {
    let tree = makeBeverageTree()
    tree.forEachDepthFirst {
        print($0.value)
    }
}

example(of: "level-order traversal") {
    let tree = makeBeverageTree()
    tree.forEachLevelOrder {
        print($0.value)
    }
}

example(of: "searching for a node") {
    let tree = makeBeverageTree()
    if let searchingReslut1 = tree.search("hot") {
        print("Found node: \(searchingReslut1.value)")
    }
    
    if let searchResult2 = tree.search("WKD Blue") {
        print(searchResult2.value)
    } else {
        print("Couldn't find WKD Blue")
    }
    
}

//Challenge 1: Print a tree in level order
//Print all the values in a tree in an order based on their level. Nodes in the same level should be printed on the same line. For example, consider the following tree:

func printEachLevel<T>(for tree: TreeNode<T>) {
    
    var arry:[TreeNode<T>] = []
    
    var nodesLeftInCurrentLevel = 0
    arry.append(tree)
    while !arry.isEmpty {
        nodesLeftInCurrentLevel = arry.count
        
        while nodesLeftInCurrentLevel > 0 {
            guard let node = arry.first else { break }
            arry.removeFirst()
            print("\(node.value)",terminator:" ")
            
            node.children.forEach{arry.append($0)}
            nodesLeftInCurrentLevel -= 1
        }
        print()
    }
}

func printEachLevel1<T>(for tree: TreeNode<T>) {

    var queue = Queue<TreeNode<T>>()
    
    var nodesLeftCurrent = 0
    queue.enqueue(tree)
    
    while !queue.isEmpty {
        nodesLeftCurrent = queue.count
        
        while nodesLeftCurrent > 0 {
            guard let node = queue.dequeue() else { break }
            print("\(node.value)",terminator:" ")
            node.children.forEach{ queue.enqueue($0) }
            nodesLeftCurrent -= 1
        }
        print()
    }
}


example(of: "Print a tree in level order") {
    
    let tree = TreeNode("15")
    let tree1 = TreeNode("1")
    let tree2 = TreeNode("17")
    let tree3 = TreeNode("20")
    let tree4 = TreeNode("1")
    let tree5 = TreeNode("5")
    let tree6 = TreeNode("0")
    let tree7 = TreeNode("2")
    let tree8 = TreeNode("5")
    let tree9 = TreeNode("7")
    
    let tree10 = TreeNode("9")

    tree.add(tree1)
    tree.add(tree2)
    tree.add(tree3)
    
    tree1.add(tree4)
    tree1.add(tree5)
    tree1.add(tree6)
    
    tree2.add(tree7)
    tree3.add(tree8)
    
    tree3.add(tree9)
    
    tree9.add(tree10)
    
    printEachLevel1(for: tree)
    
}

//Challenge 2: Parents and ownership


