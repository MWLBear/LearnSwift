
import SwiftUI

struct AwardInformation {
  public var awardView: AnyView
  public var title: String
  public var description: String
  public var awarded: Bool
}

extension AwardInformation: Hashable {
  static func == (lhs: AwardInformation, rhs: AwardInformation) -> Bool {
    if lhs.title == rhs.title && lhs.description == rhs.description && lhs.awarded == rhs.awarded {
      return true
    }
    
    return false
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(title)
    hasher.combine(description)
    hasher.combine(awarded)
  }
}
