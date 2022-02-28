import UIKit

//函数的柯里化
func addTo(_ adder:Int)->(Int)->(Int){
    return { num in
        return num + adder
    }
}

let addTwo = addTo(2)
debugPrint(addTwo)
let reslut = addTwo(6)

func greaterThan(_ comparer: Int) -> (Int)->Bool {
    return { $0 > comparer}
}

let greaterThan10 = greaterThan(10)
greaterThan10(14)
greaterThan10(9)


//其它的例子
class BankAccount {
    var balance: Double = 0.0

    func deposit(_ amount: Double) {
        balance += amount
    }
}

let account = BankAccount()
account.deposit(100) // balance is now 100

/*
 swift中的实例方法只是一个类型方法，它将实例作为参数并返回一个函数
 然后将其应用于实例
 */
let depositor = BankAccount.deposit(_:)
depositor(account)(100)

BankAccount.deposit(account)(100)


//实际例子

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T:AnyObject> : TargetAction {
    weak var target: T?
    let action: (T) -> ()->()
    func performAction()->() {
        if let t = target {
            action(t)()
        }
    }
}
enum ControlEvent{
    case touchUpInside
    case valueChange
}

class Control {
    var actions = [ControlEvent:TargetAction]()
    func setTarget<T:AnyObject>(_ target: T, action: @escaping (T)->()->(),controlEvent:ControlEvent){
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    func removeTargetForControlEvent(controlEvent: ControlEvent){
        actions[controlEvent] = nil
    }
    func preformActionForControlEvent(controlEvent:ControlEvent){
        actions[controlEvent]?.performAction()
    }
}

class MyViewController {
    let button = Control()
    
    func viewDidload(){
        let action = MyViewController.onButtonTap
        button.setTarget(self, action: action, controlEvent: .touchUpInside)
    }
    
    func onButtonTap(){
        print("Button was tapped")
    }

}












