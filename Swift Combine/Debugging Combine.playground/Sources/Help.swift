import Foundation

public func example(_ str: String, action:()->())  {
    print(str+" -------------------")
    action()
}
