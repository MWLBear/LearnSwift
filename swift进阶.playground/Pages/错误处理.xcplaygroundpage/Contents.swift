//: [Previous](@previous)

import Foundation
import UIKit

/**
 
 */

//Reslut 类型

enum Result0<A>{
    case failure(Error)
    case sucess(A)
}

enum FileError: Error {
    case fileDoesNotExist
    case noPermission
}

//带有类型的错误

enum Result<A,ErrorType:Error>{
    case failure(ErrorType)
    case sucess(A)
}
//defer 块会在作用域结束的时候被执行，而不管作用域结束的原因到底是什么。
