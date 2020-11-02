/**

 trie（发音为try）是一棵树，专门用于存储可以表示为集合的数据
 trie，又称前缀树或字典树，是一种有序树，用于保存关联数组，其中的键通常是字符串。与二叉查找树不同，键不是直接保存在节点中，而是由节点在树中的位置决定。一个节点的所有子孙都有相同的前缀，也就是这个节点对应的字符串，而根节点对应空字符串。
 
 
          root
   C        T       B
 A       U               O
T.             T.
        E.
 
 A trie containing the words CAT, CUT, CUTE, TO, and B
 
 trie数据结构对于此类问题具有出色的性能特征。作为带有支持多个子节点的节点的树，每个节点可以代表一个字符。
 通过用黑点表示的特殊指示符（终结符）跟踪从根到节点的字符集合，形成单词。trie的一个有趣的特征是多个单词可以共享相同的字符。
 
 
 关键点
 •尝试在前缀匹配方面提供了出色的性能指标。
 •尝试可以提高内存效率，因为各个节点可以在许多不同的值之间共享。 例如，“car”，“carbs”和“care”可以共享单词的前三个字母。
 
 */

example(of: "inster add contains") {
    let tire = Trie<String>()
    tire.insert("cut")
    tire.insert("cute")
    if tire.contains("cute") {
        print("cute is in trie")
    }
}

example(of: "remove") {
    let trie = Trie<String>()
    trie.insert("cut")
    trie.insert("cute")
    print("\n*** Before removing ***")
    assert(trie.contains("cut"))
    print("\"cut\" is in the trie")
    assert(trie.contains("cute"))
    print("\"cute\" is in the trie ")

    print("\n*** After removing ***")
    trie.remove("cut")
    assert(!trie.contains("cut"))
    assert(trie.contains("cute"))
    print("\"cute\" is still in the trie")
}

example(of: "prefix matching") {
    let trie = Trie<String>()
    trie.insert("car")
    trie.insert("card")
    trie.insert("care")
    trie.insert("cared")
    trie.insert("cars")
    trie.insert("carbs")
    trie.insert("carapace")
    trie.insert("cargo")
    print("\nCollections starting with \"car\"")
    let prefixedWithCar = trie.collections(startingWith: "car")
    print(prefixedWithCar)
    print("\nCollections starting with \"care\"")
    let prefixedWithCare = trie.collections(startingWith: "care")
    print(prefixedWithCare)
}
