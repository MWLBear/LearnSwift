//
//  ViewController.swift
//  swift并发_05
//
//  Created by admin on 2022/5/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task {
            
//            await Op().baz()
            
          await  Room().tryjoin()
        }
    }
}


//“Room 的成员被隔离在了 actor 自身所定义的隔离域 (actor isolated scope) 中。”
//“对于 Swift 中的 actor 模型，最重要的就是理解隔离域，并记住两个结论：
//1.某个隔离域中的声明，可以无缝访问相同隔离域中的其他成员；
//2.某个隔离域外的声明，不论它位于传统的非隔离中，还是位于其他 actor 的隔离域中，都无法直接访问这个隔离域的成员。只有通过异步消息的方法，才能跨越隔离域进行访问。”


//“到目前为止，我们已经掌握了下面几个事实：
//1.在 actor 中的声明，默认处于 actor 的隔离域中。
//2.在 actor 中的声明，如果加上 nonisolated，那么它将被置于隔离域外。
//3.在 actor 外的声明，默认处于 actor 隔离域外。”



actor Room{
    let roomNumber = "101"
    var visitorCount:Int = 0
    private let person: Person
    
    init(){
        person = Person(name: "Lee", age: 18)
    }
    func visit() -> Int {
        visitorCount += 1
        return visitorCount
    }
    
    func reportPopular(){
        if internalPopular {
            print("popular")
        }
    }
    
    func tryjoin() async {
        let room = Room()
        await reportRoom(room: room)
        
        reportRoom(room: self)
    }
    
}

class Person: CustomStringConvertible {
    
    var name: String
    var age: Int
    init(name: String,age: Int){
        self.name = name
        self.age = age
    }
    
    
    var description: String {
        "Name:\(self.name),age:\(self.age)"
    }
}



//从 actor 外部持有对这个 actor 的引用，并对某个具有 actor 隔离特性的声明的访问，叫做跨 actor 调用。这种调用只有在异步时可以使用：
class Op{
    
    func foo (){
        let room = Room()
        print(room)
    }
    
    
    func bar() async{
        let room = Room()
        let number = await room.visit()
        print(number)
        print(await room.visitorCount)
        
    }
    
    func baz() async {
        let room = RoomClass()
        print(room.popularAsync)
        
        let room1: PopularAsync = RoomClass()
        print(await room1.popularAsync)
    }
    
    func fur<T: PopularAsync>(value:T) async {
        print(await value.popularAsync)
    }
    
}


extension Room : PopularActor {
    var popularActor: Bool {
        visitorCount > 10
    }
}

extension Room : PopularAsync{
   
    private var internalPopular: Bool {
        visitorCount > 10
    }
    
    var popularAsync: Bool {
        get async {
            internalPopular
        }
    }
}

//nonisolated 标记的成员，无法访问那些隔离域内的成员，否则将违反基本的并发安全假设，让 actor 类型变得不安全。
extension Room: CustomStringConvertible {
    nonisolated var description: String {
       "Room Visited:\(roomNumber)"
    }
}

extension Room {
    func changePersonName(){
        person.name = "Bruce"
        print("Person:\(person)")
    }
    nonisolated func unsafeChangePersonName(){
        person.name = "Bruce"
        print("Person:\(person)")
    }
}


//Actor 协议细分
protocol PopularActor: Actor {
    var popularActor: Bool { get }
}

//定义异步协议
protocol PopularAsync {
    var popularAsync:Bool { get async}
}

class RoomClass: PopularAsync {
    //“因为同步函数其实是异步函数的子集和“特例”，所以普通类型是可以用同步函数来实现这个协议的异步定义的”
    var popularAsync: Bool { return true }
}


//在函数参数的类型前，加上 isolated，将把这个函数放到该参数 actor (这里是 room) 的隔离域中。这样，在函数体内部调用隔离域内的成员，就可以使用同步的方式了
//当从隔离域内部使用时，可以以同步方式直接访问；但当从隔离域外使用时，则需要 await
func reportRoom(room: isolated Room){
    print("Room:\(room.visitorCount)")
}
