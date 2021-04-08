//
//  String+AddText.swift
//  MyLocations
//
//  Created by admin on 2021/4/8.
//

import UIKit

extension String {
    mutating func add(text: String?,separatedBy separator: String = ""){
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}
