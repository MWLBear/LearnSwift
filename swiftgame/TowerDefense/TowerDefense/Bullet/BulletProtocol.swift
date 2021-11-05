//
//  BulletProtocol.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/9/27.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import Foundation
import CoreGraphics

protocol BulletProtocol {
	var atk: Int { set get }
	var contactIsRemove: Bool { get }
	var flySpeed: CGFloat { get }
	func runAnimation()
}
