##### 多语言步骤
- cd到项目目录
- `genstrings -o en.lproj Views/*.swift Model/*.swift`



SwiftUI 有两项指导原则来管理数据在 app 中的流动方式：

- Data access = dependency: Reading a piece of data in your view creates a dependency for that data in that view. Every view is a function of its data dependencies — its inputs or state.
- Single source of truth: Every piece of data that a view reads has a source of truth, which is either owned by the view or external to the view. Regardless of where the source of truth lies, you should always have a single source of truth.


•数据访问=依赖项：在视图中读取一段数据会为该视图中的数据创建依赖项。每个视图都是其数据依赖项（其输入或状态）的函数。

•单一真相来源：视图读取的每个数据都有一个真相来源，该来源要么归视图所有，要么在视图外部。无论真相的来源在哪里，你总是应该有一个单一的真相来源

每个包装器都指示不同的数据来源：

• @State属性是真理的来源。一个视图拥有它并传递其价值或

引用，称为绑定，对其子视图。

• @Binding属性是对另一个视图拥有的@State属性的引用。当另一个视图使用$前缀通过绑定时，它会获得初始值。对真相来源的引用使子视图能够更改属性的值，从而更改依赖于此属性的任何视图的状态。

• @EnvironmentObject声明依赖于某些共享数据——这些数据对应用程序子树中的所有视图可见。这是一种间接传递数据的便捷方式，而不是将数据从父视图传递给孩子再传递给孙子，特别是在介于儿童视图之间时。

