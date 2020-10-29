public struct BinarySearchTree<Element: Comparable> {
    
    public private(set) var root: BinaryNode<Element>?
    
    public init() {}
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        guard let root = root else {
            return "empty tree"
        }
        return String(describing: root)
    }
}

extension BinarySearchTree {
    
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
        
    }
    //根据BST的规则，左子节点的节点必须包含小于当前节点的值。 右子节点的节点必须包含大于或等于当前节点的值。
    private func insert(from node: BinaryNode<Element>?, value: Element)
        -> BinaryNode<Element> {
            guard let node = node else { //3
                return BinaryNode(value: value)
            }
            if value < node.value { // 1<3
                node.leftChild = insert(from: node.leftChild, value: value)
            }else {
                node.rightChild = insert(from: node.rightChild, value: value)
            }
            return node
    }
}

extension BinarySearchTree {
    
    public func contains__(_ value: Element) -> Bool {
        guard let root = root else {
            return false
        }
        var found = false
        root.traverseInOrder {
            if $0 == value {
                found = true
            }
        }
        return found
    }
    
    public func contains(_ value: Element) -> Bool {
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value
            {
                current = node.leftChild
            }else {
                current = node.rightChild
            }
        }
        return false

    }
}

private extension BinaryNode {
    var min: BinaryNode {
        leftChild?.min ?? self
    }
}

extension BinarySearchTree {
    public mutating func remove(_ value: Element){
        root = remove(node: root, value: value)
    }
    
    /**
     
                3
                ^
            1       4
            ^       ^
         0    2    5
     
     
     */
    
    private func remove(node: BinaryNode<Element>?, value: Element)
        -> BinaryNode<Element>?{
            guard let node = node else {
                return nil
            }
            
            if value == node.value {
                if node.leftChild == nil && node.rightChild == nil {
                    return nil
                }
                if node.leftChild == nil {
                    return node.rightChild
                }
                if node.rightChild == nil {
                    return node.leftChild
                }
                node.value = node.rightChild!.min.value
                node.rightChild = remove(node: node.rightChild, value: node.value)
                
            } else if value < node.value {
                node.leftChild = remove(node: node.leftChild, value: value)
            } else {
                node.rightChild = remove(node: node.rightChild, value: value)
            }
            return node
    }
}
