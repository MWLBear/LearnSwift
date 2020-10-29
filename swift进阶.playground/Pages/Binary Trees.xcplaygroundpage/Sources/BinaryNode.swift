public class BinaryNode<Element> {
    
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
    
}

extension BinaryNode: CustomStringConvertible {
    public var description: String {
        diagram(for: self)
    }
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
            
        }
        
       return diagram(for: node.rightChild,
                      top + " ", top + "┌──", top + "│ ")
        + root + "\(node.value)\n"
        + diagram(for: node.leftChild,
                  bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

/**
In-order traversal  中序遍历
 
 左子树-->根结点-->右子树。
 
 从根节点开始
 •如果当前节点有左子树，请首先递归访问该子节点。
 •然后访问节点本身。
 •如果当前节点有右子树，则递归访问该节点。
 
 */

/**
 
Pre-order traversal  前序遍历
 
根结点-->左子树-->右子树。
 
Pre-order traversal always visits the current node first, then recursively visits the left and right child:
预定遍历始终先访问当前节点，然后递归访问左子树和右子树：

*/
/**
 Post-order traversal  后序遍历
 
 左子树-->右子树-->根结点
 
 后序遍历仅在递归访问左右子节点之后才访问当前节点。
 换句话说，在给定任何节点的情况下，您需要先访问其子节点，然后再访问其自身。 一个有趣的结果是，根节点总是最后访问。
 
 */

extension BinaryNode {
    
    //中序遍历
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    //先序遍历
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    
    //后序遍历
    public func traversePostOrder(visit : (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}


extension BinaryNode{
    func maxDepth(_ tree: BinaryNode?) -> Int {
        guard let root = tree else {
            return 0
        }
        return max(maxDepth(root.leftChild), maxDepth(root.rightChild)) + 1
    }
}
