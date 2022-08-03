import Foundation

extension FileManager {
  static var documentURL: URL? {
    return Self.default.urls(
      for: .documentDirectory,
      in: .userDomainMask).first
  }
}
