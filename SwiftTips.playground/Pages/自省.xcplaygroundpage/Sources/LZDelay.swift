import Foundation

class  LZDelay{
    
    typealias Task = (_ cancel: Bool) -> Void

    static func delay(_ time: TimeInterval, task: @escaping () -> Void) -> Task? {
        
        func dispatch_later(block: @escaping () -> Void) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        
        var closure: (() -> Void)? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if cancel == false {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
         
            closure = nil
            result = nil
        }
        result = delayedClosure

        dispatch_later {
            
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        return result
    }

    static func cancel(_ task: Task?) {
        task?(true)
    }
}
