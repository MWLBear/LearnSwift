//
//  MapNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/31.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class MapNode: SKSpriteNode {

	var myPause: Bool = false {
		didSet {
			isPaused = myPause
		}
	}
	
	override var isPaused: Bool {
		get {
			return myPause
		}
		set {
			super.isPaused = isPaused
		}
	}
}
