//
//  MonsterNode.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/9.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit

class MonsterNode: SKSpriteNode {

    public var didDie: (() -> Void)?
	
	public var didToEndPoint: (() -> Void)?
	
	public var maps: (() -> [[SearchItem]]?)?
	    
    public var isDie: Bool = false
	
	private var runSpeed: CGFloat = 100
	
	private var runTimePerFrame: TimeInterval = 0.1
	
	public var fullPaths: [SearchItem]?
	
	
	static func newNode() -> MonsterNode {
		let node = MonsterNode.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 50, height: 50))
		return node
	}
	
	public var type: Int = 1 {
		didSet {
			bodyNode.texture = SKTexture.init(imageNamed: "monster\(type)_0")
			var arr = [SKTexture]()
			for i in 0 ... 3 {
				let t = SKTexture.init(imageNamed: "monster\(type)_\(i)")
				arr.append(t)
			}
			runTimePerFrame = 0.1
			runAction = SKAction.repeatForever(SKAction.animate(with: arr, timePerFrame: 0.1, resize: false, restore: false))
			if type == 1 {
				runSpeed = 100
				originBlood = 20
			} else if type == 2 {
				runSpeed = 95
				originBlood = 30
			} else if type == 3 {
				runSpeed = 90
				originBlood = 40
			} else if type == 4 {
				runSpeed = 105
				originBlood = 50
			} else if type == 5 {
				runSpeed = 180
				originBlood = 60
				runTimePerFrame = 0.2
			} else if type == 6 {
				runSpeed = 105
				originBlood = 70
			} else if type == 7 {
				runSpeed = 80
				originBlood = 80
			} else if type == 8 {
				runTimePerFrame = 0.2
				runSpeed = 190
				originBlood = 90
			} else if type == 9 {
				runTimePerFrame = 0.2
				runSpeed = 185
				originBlood = 100
			} else if type == 10 {
				runTimePerFrame = 0.2
				runSpeed = 200
				originBlood = 200
			}
			blood = originBlood
			runSpeed = runSpeed * 0.7
		}
		
	}
	
	var originBlood: Int = 0
	
	var blood: Int = 0 {
		didSet {
			let progress = CGFloat(blood) / CGFloat(originBlood)
			bloodNode.setPregress(progress, animated: progress != 1)
		}
	}
	
	lazy var bloodNode: ProgressNode = {
		let node = ProgressNode.newNode()
		node.position = CGPoint.init(x: 0, y: 30)
		return node
	}()
	
	lazy var bodyNode: SKSpriteNode = {
		let texture = SKTexture.init(imageNamed: "monster1_0")
		let node = SKSpriteNode.init(texture: texture, color: UIColor.red, size: texture.size())
		node.position = CGPoint.zero
		return node
	}()
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: texture, color: color, size: size)
		self.physicsBody = {
			let body = SKPhysicsBody.init(circleOfRadius: 15)
			body.affectedByGravity = false
			body.allowsRotation = false
			body.usesPreciseCollisionDetection = true
			body.categoryBitMask = BodyType.monster.rawValue
			body.collisionBitMask = 0
			body.contactTestBitMask = BodyType.bullet.rawValue
			return body
		}()
		zPosition = 3
		addChild(bloodNode)
		addChild(bodyNode)
	}
	
	/// 添加减速效果
	func addIceEffect() {
		removeIceEffect()
		let manAction = SKAction.run { [weak self] in
			self?.speed = 0.5
			self?.bodyNode.color = UIColor.blue
			self?.bodyNode.colorBlendFactor = 0.6
		}

		let durationAction = SKAction.wait(forDuration: 2)
		let kuaiAction = SKAction.run { [weak self] in
			self?.speed = 1
			self?.bodyNode.color = UIColor.clear
			self?.bodyNode.colorBlendFactor = 0
		}
		let action = SKAction.sequence([manAction, durationAction, kuaiAction])
		self.run(action, withKey: "addIceEffect")
	}
	
	/// 移除减速效果
	func removeIceEffect() {
		self.speed = 1
		bodyNode.color = UIColor.clear
		bodyNode.colorBlendFactor = 0
		removeAction(forKey: "addIceEffect")
	}
	
	override func removeAllActions() {
		super.removeAllActions()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	var runAction: SKAction?
	func runAnimation() {
		if let action = runAction {
			bodyNode.run(action)
		}
	}
	
	/// 减少血量
	func reduceBlood(_ value: Int) {
        if !isDie {
            if blood - value < 0 {
                blood = 0
            } else {
                blood = blood - value
            }
            if blood == 0 {
                isDie = true
				stopRunAnimated()
				removeFromParent()
                self.didDie?()
            }
        }
	}
    
    /// 重置怪物
    func resetNode() {
        blood = originBlood
        isDie = false
		fullPaths = nil
		removeIceEffect()
		stopRunAnimated()
		removeFromParent()
    }
	
	func stopRunAnimated() {
		removeAction(forKey: "run")
	}
	
	func startFindPath(for towerMapPoint: MapPoint? = nil) {
		var needFind: Bool = false
		
		if let paths = fullPaths, let tPoint = towerMapPoint, paths.count > 0 {
			for p in paths {
				if p.x == tPoint.x &&  p.y == tPoint.y {
					needFind = true
					break
				}
			}
		} else {
			needFind = true
		}
		guard needFind else {
			return
		}
		stopRunAnimated()
		let sta = self.position.fixToMapPoint()
		let start = SearchItem()
		start.x = sta.x
		start.y = sta.y
		let end = SearchItem()
		end.x = 5
		end.y = 23
		let search = Search.init(start: start, end: end, map: self.maps!()!)
		let arr = search.startSearch()
		if arr.count > 0 {
			fullPaths = arr
			var paths: [CGPoint] = [CGPoint]()
			for (i, item) in arr.enumerated() {
				if i == 0 {
					let point = MapPoint.init(x: item.x, y: item.y).fixToMapPositon()
					paths.append(point)
//					self.position = point
				} else if i == arr.count - 1 {
					paths.append(MapPoint.init(x: item.x, y: item.y).fixToMapPositon())
				} else {
					let last = arr[i - 1]
					let next = arr[i + 1]
					if last.x != next.x && last.y != next.y {
						paths.append(MapPoint.init(x: item.x, y: item.y).fixToMapPositon())
					}
				}
			}
			var actions: [SKAction] = [SKAction]()
			
			for (i, point) in paths.enumerated() {
				if i < paths.count - 1 {
					let next = paths[i + 1]
					let duration = point.distance(to: next) / runSpeed
					let moveAction = SKAction.move(to: next, duration: TimeInterval(duration))
					var angle: Double = 0
					if next.x > point.x {
						//右
						angle = Double.pi / 2.0
					} else if next.y > point.y {
						//上
						angle = Double.pi
					} else if next.x < point.x {
						//左
						angle = -Double.pi / 2.0
					} else if next.y < point.y {
						//下
						angle = 0
					}
					
					let rotateAction = SKAction.run {
						let action = SKAction.rotate(toAngle: CGFloat(angle), duration: 0.1)
						self.bodyNode.run(action)
					}
					
					actions.append(SKAction.group([moveAction, rotateAction]))
				}
			}
			actions.append(SKAction.run {
				self.resetNode()
				self.didToEndPoint?()
			})
			self.run(SKAction.sequence(actions), withKey: "run")
		}
	}
}
