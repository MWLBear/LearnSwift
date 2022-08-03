//
//  AngleExtensions.swift
//  Cards
//
//  Created by admin on 2022/8/2.
//

import SwiftUI
extension Angle: Codable {

  enum CodingKeys: CodingKey {
    case degress
  }
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let degrees = try container.decode(Double.self, forKey: .degress)
    self.init(degrees: degrees)
  }

  public func encode(to encoder: Encoder) throws {
    
  }
}
