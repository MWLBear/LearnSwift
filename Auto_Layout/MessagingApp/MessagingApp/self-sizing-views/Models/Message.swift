import Foundation
struct Message {
  var text:String
  var sentByMe:Bool
  var imageName:String?
  var isLiked: Bool = false
  var isisFavorited: Bool = false
  static func fetchAll() -> [Message] {
    var messages = [Message]()
    messages.append(Message(text: "Hello, it's me", sentByMe: true,imageName: "selfie"))
    messages.append(Message(text: "I was wondering if you'll like to meet, to go over this new tutorial I'm working on", sentByMe: true))
    messages.append(Message(text: "I'm in California now, but we can meet tomorrow morning, at your house", sentByMe: false))
    messages.append(Message(text: "Sound good! Talk to you later", sentByMe: true))
    messages.append(Message(text: "Ok :]", sentByMe: false,imageName: "ok"))
    return messages
    
  }
}
