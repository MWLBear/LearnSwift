import Foundation

//challenge 1 Reverse an Array
public func printInResverse<T>(_ arry:[T]){
    var stack = Stack<T>()
    
    for value in arry {
        stack.push(value)
    }
    
    while let value = stack.pop() {
        print(value)
    }
}

//challenge 2  Balance the parentheses
//O(n)-O(n)
public func checkParentheses(_ string:String)->Bool{
    var stack = Stack<Character>()
    
    for character in string{
        if character == "(" {
            stack.push("(")
        }else if character == ")"{
            if stack.isEmpty {
                return false
            }else{
                stack.pop()
            }
        }
    }
    
    return stack.isEmpty
}
