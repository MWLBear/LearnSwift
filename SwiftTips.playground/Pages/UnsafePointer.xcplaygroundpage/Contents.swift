//: [Previous](@previous)

import CoreFoundation
import Foundation

func method(_ num: UnsafePointer<CInt>) {
    print(num.pointee)
}

var a: CInt = 123
method(&a)

let arr = NSArray(object: "meow")
let str = unsafeBitCast(CFArrayGetValueAtIndex(arr, 0), to: CFString.self)
// unsafeBitCast 会将第一个参数的内容按照第二个参数的类型进行转换，而不去关心实际是不是可 行，这也正是 UnsafePointer 的不安全所在，因为我们不必遵守类型转换的检查，而拥有了在指针 层面直接操作内存的机会。

// C 指针内存管理

class MyClass {
    var a = 1
    deinit {
        print("deinit")
    }
}

var pointer: UnsafeMutablePointer<MyClass>!
pointer = UnsafeMutablePointer<MyClass>.allocate(capacity: 1)
pointer.initialize(to: MyClass())

print(pointer.pointee.a)
pointer.deinitialize(count: 1)
pointer.deallocate()
pointer = nil

var x: UnsafeMutablePointer<tm>!
var t = time_t()
time(&t)
x = localtime(&t)
print(x.self)
x = nil




//时间
func uptime() -> time_t {
    var boottime = timeval()

    var mib: [Int32] = [CTL_KERN, KERN_BOOTTIME]

    var size = MemoryLayout.stride(ofValue: timeval())

    var now = time_t()

    var uptime: time_t = -1

    time(&now)

    if sysctl(&mib, 2, &boottime, &size, nil, 0) != -1 && boottime.tv_sec != 0 {
        uptime = now - boottime.tv_sec
    }

    return uptime
}

//: [Next](@next)
