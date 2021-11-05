//
//  MapConfig.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/9/5.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import Foundation

class MapConfig: NSObject {

	var map: [[Int]]!
	var mapName: String
	var mapPreviewName: String
	var mapSmallName: String
	var type: Int
	
	init(type: Int) {
		self.type = type
		self.mapName = "map\(type)"
		self.mapPreviewName = "map\(type)preview"
		self.mapSmallName = "map\(type)small"
		super.init()
		switch type {
		case 1:
			map = Array<Int>.map1
		case 2:
			map = Array<Int>.map2
		case 3:
			map = Array<Int>.map3
		case 4:
			map = Array<Int>.map4
		case 5:
			map = Array<Int>.map5
		case 6:
			map = Array<Int>.map6
		case 7:
			map = Array<Int>.map7
		case 8:
			map = Array<Int>.map8
		case 9:
			map = Array<Int>.map9
		case 10:
			map = Array<Int>.map10
		default:
			map = Array<Int>.map1
		}
	}
	
}
