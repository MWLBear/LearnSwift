//: [Previous](@previous)

import UIKit

protocol MyClassDelegate: AnyObject {
    func method()
}

class MyClass {
    weak var delegate: MyClassDelegate?
}

class ViewController: UIViewController, MyClassDelegate {
    var someInstance: MyClass!
    override func viewDidLoad() {
        super.viewDidLoad()
        someInstance = MyClass()
        someInstance.delegate = self
    }

    func method() {
        print("Do something")
    }
}

//: [Next](@next)
