//
//  TextureAtlasManager.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/30.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit
import RNCryptor

class TextureAtlasManager: NSObject {
	var uiAtlas: SKTextureAtlas!
	
	static let shared: TextureAtlasManager = TextureAtlasManager()
	
	func start() {
		var dictionary: [String : UIImage] = [String : UIImage]()
		let arr = try? FileManager.default.contentsOfDirectory(atPath: Bundle.main.bundlePath + "/UI")
		
		if let arr = arr {
			for name in arr {
				let path = Bundle.main.bundlePath + "/UI/" + name
				let url = URL.init(fileURLWithPath: path)
				let originData = try? Data.init(contentsOf: url)
				if let od = originData {
					let data = try? RNCryptor.decrypt(data: od, withPassword: "songnaiyin")
					if let d = data {
						let img = UIImage.init(data: d)
						dictionary[name] = img
					}
				}
			}
		}
		
		uiAtlas = SKTextureAtlas.init(dictionary: dictionary)
	}
	
	override init() {
		super.init()
		
		
		
	}
	
}
