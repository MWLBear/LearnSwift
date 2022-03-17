//: [Previous](@previous)

import Foundation
// jsonString

// jsonString
//{"menu": {
//   "id": "file",
//   "value": "File",
//   "popup": {
//       "menuitem": [
//           {"value": "New", "onclick": "CreateNewDoc()"},
//           {"value": "Open", "onclick": "OpenDoc()"},
//           {"value": "Close", "onclick": "CloseDoc()"}
//] }
//}}

let jsonString = ""


struct Obj: Codable {
    let menu: Menu
    
    struct Menu: Codable {
        let id: String
        let value: String
        let popup: Popup
    }
    
    struct Popup: Codable {
        let menuItme: [MeunItem]
        enum CodingKeys: String,CodingKey{
            case menuItme = "menuitem"
        }
    }
    
    struct MeunItem: Codable {
        let value: String
        let onClick: String
        
        enum CodingKeys: String,CodingKey{
            case value
            case onClick = "onclick"
        }
    }
}

let data = jsonString.data(using: .utf8)!
do {
    let obj = try JSONDecoder().decode(Obj.self, from: data)
    let value = obj.menu.popup.menuItme[0].value
}catch {
    print("出错了：\(error)")
}


/**
A demo method
- parameter input: An Int number
- returns: The string represents the input number
*/


func method(input: Int) -> String {
    return String(input)
}

method(input: 1)

struct Person {
   /// name of the person
   var name: String
}

//: [Next](@next)
