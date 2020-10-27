import Foundation

/**
 
 There are only two essential operations for a stack:
 
 • push: Adding an element to the top of the stack.
 • pop: Removing the top element of the stack.
 
 Stack operations
 
 
 LIFO(Last-in first-out)
 
 后进先出
 
 
 
 Key points
 • A stack is a LIFO, last-in first-out, data structure.
 
 The only two essential operations for the stack are the push method for adding elements and the pop method for removing elements.
 
 */

example(of:"using a stack"){
    var stack = Stack<Int>()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(4)

    print(stack)
    
    if let poppedElement = stack.pop() {
        assert(4 == poppedElement)
        print("Popped:\(poppedElement)")
    }
}


example(of: "initializing a stack from an arry") {
    let arry = ["a","b","c","d"]
    var stack = Stack(arry)
    print(stack)
    stack.pop()
}

example(of: "initializing a stack from an array literal") {
    var stack: Stack = [1.0, 2.0, 3.0, 4.0]
    print(stack)
    stack.pop()
}

//challenge 1 Reverse an Array

printInResverse(["我","是","谁"])


//Balance the parentheses
checkParentheses("h((e))llo(world)()")
checkParentheses("(hello world")

