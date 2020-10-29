public final class AVLNode<Element> {
    
    public var value: Element
    public var leftChild: AVLNode?
    public var rightChild: AVLNode?
    //节点的高度是当前节点到叶节点的最长距离
    public var height = 0
    
    //每个节点的左右子节点的高度最多必须相差1。这称为平衡因子。
    //balanceFactor计算左右孩子的身高差。 如果特定孩子为零，则其身高被视为-1。
    public var balanceFactor: Int {
        leftHeight - rightHeight
    }
    public var leftHeight: Int {
        leftChild?.height ?? -1
    }
    public var rightHeight: Int {
        rightChild?.height ?? -1
    }
    
    public init(value: Element) {
        self.value = value
    }
}

extension AVLNode: CustomStringConvertible {
    
    public var description: String {
        diagram(for: self)
    }
    
    private func diagram(for node: AVLNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild, top + " ", top + "┌──", top + "│ ")
            + root + "\(node.value)\n"
            + diagram(for: node.leftChild, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

//extension AVLNode {
//
//    public func traverseInOrder(visit: (Element) -> Void) {
//        leftChild?.traverseInOrder(visit: visit)
//        visit(value)
//        rightChild?.traverseInOrder(visit: visit)
//    }
//
//    public func traversePreOrder(visit: (Element) -> Void) {
//        visit(value)
//        leftChild?.traversePreOrder(visit: visit)
//        rightChild?.traversePreOrder(visit: visit)
//    }
//
//    public func traversePostOrder(visit: (Element) -> Void) {
//        leftChild?.traversePostOrder(visit: visit)
//        rightChild?.traversePostOrder(visit: visit)
//        visit(value)
//    }
//}

