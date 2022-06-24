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


### Wrapping Values(包装值)
@State 和 @Binding 是值属性包装器的主力。如果视图没有从任何父视图接收到值，则视图拥有该值。在这种情况下，它是一个 @State 属性——唯一的事实来源。首次创建视图时，它会初始化其 @State 属性。当@State 值改变时，视图会重绘自身，重置除@State 属性之外的所有内容。

拥有视图可以将@State 值作为普通只读值或作为读写@Binding 传递给子视图。

当您为应用程序制作原型并尝试子视图时，您可能会将其编写为仅具有 @State 属性的独立视图。稍后，当您将其放入您的应用程序时，您只需将来自父视图的值更改为 @State 为 @Binding。

您的应用可以访问内置的 @Environment 值。环境值保留在您附加到的视图的子树中。通常，这只是像 VStack 这样的容器，您可以在其中使用环境值来设置默认值，如字体大小。

注意：您还可以定义自己的自定义环境值，例如将视图的属性公开给祖先视图。这超出了本教程的范围。
您可以在 @AppStorage 或 @SceneStorage 字典中存储一些值。 @AppStorage 值在 UserDefaults 中，因此它们在应用程序关闭后仍然存在。当应用重新打开时，您可以使用 @SceneStorage 值来恢复场景的状态。在 iOS 环境中，场景最容易被视为 iPad 上的多个窗口。

### Wrapping Objects(包装对象)
当您的应用程序需要更改并响应引用类型的更改时，您创建一个符合 ObservableObject 并发布适当属性的类。在这种情况下，您使用@StateObject 和@ObservedObject 的方式与@State 和@Binding 用于值的方式非常相似。您将视图中的发布者类实例化为@StateObject，然后将其作为@ObservedObject 传递给子视图。当拥有视图重绘自身时，它不会重置其 @StateObject 属性。

如果您的应用程序的视图需要更灵活地访问对象，您可以将其提升到视图子树的环境中，仍然是 @StateObject。您必须在此处实例化它。如果您忘记创建它，您的应用程序将会崩溃。然后使用 .environmentObject(_:) 修饰符将其附加到视图。然后，视图子树中的任何视图都可以通过声明该类型的 @EnvironmentObject 来订阅发布者对象。

要使应用程序中的每个视图都可以使用环境对象，请在应用程序创建其 Wi​​ndowGroup 时将其附加到根视图。



