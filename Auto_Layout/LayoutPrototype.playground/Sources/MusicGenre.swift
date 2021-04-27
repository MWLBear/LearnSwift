
import UIKit

public enum MusicGenre: String {
  case rock, jazz, pop, other
  public var backgroundColor: UIColor {
    switch self {
    case .rock:
      return UIColor(red:0.44, green:0.06, blue:0.10, alpha:1)
    case .jazz:
      return UIColor(red:0.43, green:0.52, blue:0.56, alpha:1)
    case .pop:
      return UIColor(red:0.57, green:0.70, blue:0.59, alpha:1)
    case .other:
      return UIColor(red:0.66, green:0.15, blue:0.57, alpha:1)
    }
  }
}
