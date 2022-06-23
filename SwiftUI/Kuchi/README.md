
 Use `@State` for simple properties that belong to a single view. They should usually be marked private.
 Use @ObservedObject for complex properties that might belong to several views. Any time you’re using a reference type you should be using @ObservedObject for it.
 Use @EnvironmentObject for properties that were created elsewhere in the app, such as shared data.

 
 
### @State
 SwiftUI使用@State属性包装器允许我们修改结构体中的值，由于结构体是值类型，通常不允许这样做。 将@State放在属性之前，可以有效地将其存储从结构中移出，并移到SwiftUI管理的共享存储中。 这意味着SwiftUI可以在需要时销毁并重新创建我们的结构（这可能会发生很多！），而不会丢失其存储状态。
 @State应该与简单的结构类型（例如String和Int）一起使用，并且通常不应与其他视图共享。 如果要在视图之间共享值，则可能应该使用@ObservedObject或@EnvironmentObject-两者都将确保在数据更改时刷新所有视图。
 为了增强@State属性的本地性，Apple建议您将其标记为私有，
 ``` @State private var usename = "" ```
 
### @Published
 @Published是SwiftUI中最有用的属性包装器之一，它使我们能够创建可观察的对象，这些对象会在发生更改时自动宣布。 SwiftUI将自动监视此类更改，并重新调用所有依赖于数据的视图的body属性。实际上，这意味着每当更改带有标记为@Published的属性的对象时，将重新加载使用该对象的所有视图以反映这些更改。
 您无需执行其他任何操作– @Published属性包装器可以有效地将willSet属性观察者添加到项目中，这样任何更改都会自动发送给观察者。
 
 
### @ObservedObject
 
 SwiftUI为我们提供了@ObservedObject属性包装器，以便视图可以监视外部对象的状态，并在重要内容发生变化时得到通知。
 
 ```
 class Order: ObservableObject {
     @Published var items = [String]()
 }

 struct ContentView: View {
     @ObservedObject var order = Order()

     var body: some View {
         // your code here
     }
 }
 ```
 ContentView使用 @ObservedObject来监视那些公告。如果没有@ObservedObject，则更改通知将被发送但被忽略
  
  - 一.用@ObservedObject标记的任何类型都必须符合ObservableObject协议，这反过来意味着它必须是类而不是结构。
 - 二.观察到的对象是专门为视图外部的数据设计的，这意味着它们可能在多个视图之间共享。 @ObservedObject属性包装器将自动确保密切监视该属性，以便重要的更改将重新使用该视图加载任何视图。
 - 三.并不是观察对象中的所有属性都会导致视图刷新-您需要使用@Published或自定义公告来决定哪些属性应发送更改通知。为符合ObservableObject的类型提供默认的objectWillChange发布者，以便根据需要进行自定义声明。
 
 
### @EnvironmentObject
 SwiftUI的@EnvironmentObject属性包装器使我们可以创建依赖共享数据的视图，这些视图通常跨整个SwiftUI应用程序。例如，如果创建一个将在应用程序的许多部分之间共享的用户，则应使用@EnvironmentObject。

 ``` 
 class Order: ObservableObject {
     @Published var items = [String]()
 }
 struct ContentView: View {
     @EnvironmentObject var order: Order
     var body: some View {
         // your code here
     }
 }
 ```
 
 @EnvironmentObject与@ObservedObject有很多共同点：两者都必须引用符合ObservableObject的类，都可以在许多视图之间共享，并且都可以在发生重大更改时更新正在监视的所有视图。但是，@ EnvironmentObject明确表示“此对象将由某个外部实体提供，而不是由当前视图创建或专门传递。
 实际上，假设您拥有视图A，并且视图A拥有视图E所需的一些数据。使用@ObservedObject，视图A需要将对象传递给视图B，然后将其传递给视图C，然后传递给视图D，最后传递给视图E-所有中间视图都需要发送给对象，即使它们实际上并没有需要它。
 使用@EnvironmentObject时，视图A可以创建一个对象并将其放置到环境中。然后，只要需要，它内的任何视图都可以访问该环境对象，而不必显式传递它-这使我们的代码更加简单。
### @Environment
 SwiftUI为我们提供了@Environment和@EnvironmentObject属性包装器，但是它们有细微的不同：@EnvironmentObject允许我们向环境中注入任意值，而@Environment专门用于预定义键
### @Binding
 @Binding是SwiftUI较少使用的属性包装器之一，但它仍然非常重要：它使我们声明一个值实际上来自其他地方，应该在两个地方共享。这与@ObservedObject或@EnvironmentObject不同，这两个对象都是为可能在许多视图之间共享的引用类型而设计的。
###  @GestureState
 SwiftUI为我们提供了一个特定的属性包装器，用于跟踪手势状态，称为@GestureState。尽管您可以使用简单的@State属性包装器完成相同的操作，但是@GestureState它具有附加的功能，即在手势结束时，它会自动将属性设置回其初始值。
### 总结差异:
 
 - 使用@State了属于一个单一的视图简单的属性。他们通常应该被标记private。
-  使用@ObservedObject那些可能属于多个视图的复杂性。每当使用引用类型时，都应该使用@ObservedObject它。
-  使用@EnvironmentObject针对在该应用别处创建属性，例如共享数据。
 

