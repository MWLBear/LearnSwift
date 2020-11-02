public class TrieNode<Key:Hashable> {
    //key 保存节点数据
    public var key: Key?
    
    //
    public weak var parent: TrieNode?
    
    // 在一个trie，一个节点需要容纳多个不同的元素
    public var children: [Key: TrieNode] = [:]
    public var isTerminating = false //集合结束的指示符
    
    public init(key: Key?, parent: TrieNode?){
        self.key = key
        self.parent = parent
    }
}
