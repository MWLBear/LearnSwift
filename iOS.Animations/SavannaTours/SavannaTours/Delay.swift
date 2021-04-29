//
//  Delay.swift
//  SavannaTours
//
//  Created by admin on 2021/4/28.
//

import Foundation
func delay(seconds:TimeInterval, action: @escaping () -> Void ) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: action)
}
