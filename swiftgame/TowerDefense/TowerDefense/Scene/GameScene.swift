//
//  GameScene.swift
//  TowerDefense
//
//  Created by songnaiyin on 2018/8/9.
//  Copyright © 2018年 longzhu. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	
	public var mapConfig: MapConfig!
	
	public var quitAction: (() -> Void)? {
		didSet {
			settingView.quitAction = quitAction
		}
	}

	lazy var mapNode: MapNode = {
		let node = MapNode.init(texture: nil, color: UIColor.clear, size: self.size)
		node.zPosition = -1
		node.anchorPoint = CGPoint.zero
		return node
	}()
		
	lazy var settingView: SettingNode = {
		let node = SettingNode.init(texture: nil, color: UIColor.black.withAlphaComponent(0.2), size: self.size)
		node.restartAction = { [weak self] in
			self?.restart()
			self?.resumeGame()
		}
		return node
	}()
	
	/// 加速按钮
	lazy var speedBtn: ButtonNode = {
		let node = ButtonNode.init(size: CGSize.init(width: 60, height: 50))
		node.normalTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("right1")
		node.selectedTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("right2")
		node.clickAction = { [weak self] (node) in
			node.isSelected = !node.isSelected
			self?.speed = node.isSelected ? 2 : 1
		}
		node.anchorPoint = CGPoint.init(x: 0, y: 0.5)
		node.position = CGPoint.init(x: 90, y: 50)
		return node
	}()
	
	/// topbar
	lazy var topNode: TopBarNode = {
		let node = TopBarNode.newNode()
		node.position = CGPoint.init(x: self.size.width * 0.5, y: self.size.height - 33)
		return node
	}()
	
	lazy var settingBtn: ButtonNode = {
		let node = ButtonNode.init(size: CGSize.init(width: 64, height: 66))
		node.normalTexture = SKTexture.init(imageNamed: "function")
		node.selectedTexture = SKTexture.init(imageNamed: "function2")
		node.clickAction = { [weak self] (node) in
			self?.showSettingView()
		}
		node.anchorPoint = CGPoint.init(x: 1, y: 0.5)
		node.position = CGPoint.init(x: self.size.width - 10, y: self.size.height - 50)
		return node
	}()
	
	lazy var pauseBtn: ButtonNode = {
		let node = ButtonNode.init(size: CGSize.init(width: 50, height: 54))
		node.normalTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("pause")
		node.selectedTexture = TextureAtlasManager.shared.uiAtlas?.textureNamed("pause2")
		node.clickAction = { [weak self] (node) in
				self?.pauseGame()
		}
		node.anchorPoint = CGPoint.init(x: 0, y: 0.5)
		node.position = CGPoint.init(x: 20, y: 50)
		return node
	}()
	
	lazy var playBtn: ButtonNode = {
		let node = ButtonNode.init(size: CGSize.init(width: 50, height: 54))
		node.isHidden = true
		node.normalTexture = SKTexture.init(imageNamed: "pause_press")
		node.selectedTexture = SKTexture.init(imageNamed: "play2")
		node.clickAction = { [weak self] (node) in
			self?.resumeGame()
		}
		node.anchorPoint = CGPoint.init(x: 0, y: 0.5)
		node.position = CGPoint.init(x: 20, y: 50)
		return node
	}()
	
	lazy var audioNode: SKAudioNode = {
		let node = SKAudioNode.init(fileNamed:"BGM1.mp3")
		node.isPositional = true
		return node
	}()
	
	/// 暂停游戏
	func pauseGame() {
		pauseBtn.isHidden = true
		playBtn.isHidden = !pauseBtn.isHidden
		mapNode.myPause = true
		self.isPaused = true
	}
	
	/// 恢复暂停
	func resumeGame() {
		pauseBtn.isHidden = false
		playBtn.isHidden = !pauseBtn.isHidden
		mapNode.myPause = false
		self.isPaused = false
	}
	
	func gameFailure() {
		
	}
	
	/// 显示设置页面
	func showSettingView() {
		pauseGame()
		settingView.showAt(scene: self)
	}
	
	var money: Int = 100 {
		didSet {
			upgradeNode.currentMoneyChanged()
			topNode.moneyNum = money
			if money >= 10 {
				towerTemp10.texture = SKTexture.init(imageNamed: "tower10")
				towerTemp20.texture = SKTexture.init(imageNamed: "tower20")
			} else {
				towerTemp10.texture = SKTexture.init(imageNamed: "tower11")
				towerTemp20.texture = SKTexture.init(imageNamed: "tower21")
			}
			
			if money >= 20 {
				towerTemp30.texture = SKTexture.init(imageNamed: "tower30")
			} else {
				towerTemp30.texture = SKTexture.init(imageNamed: "tower31")
			}
			
			if money >= 50 {
				towerTemp40.texture = SKTexture.init(imageNamed: "tower40")
			} else {
				towerTemp40.texture = SKTexture.init(imageNamed: "tower41")
			}
		}
	}
	
	var life: Int = 30 {
		didSet {
			topNode.lifeNum = life
		}
	}
	
	var totalNum: Int = 30 {
		didSet {
			topNode.totalWaveNum = totalNum
		}
	}
	
	var currentNum: Int = 30 {
		didSet {
			topNode.currentWaveNum = currentNum
		}
	}
	
	lazy var towerTemp10: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: "tower10"), color: UIColor.clear, size: CGSize.init(width: 100, height: 100))
		node.position = CGPoint.init(x: self.size.width - 400, y: 100)
		node.zPosition = 50
		return node
	}()
	
	lazy var towerTemp20: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: "tower20"), color: UIColor.clear, size: CGSize.init(width: 100, height: 100))
		node.position = CGPoint.init(x: self.size.width - 300, y: 100)
		node.zPosition = 50
		return node
	}()
	
	lazy var towerTemp30: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: "tower30"), color: UIColor.clear, size: CGSize.init(width: 100, height: 100))
		node.position = CGPoint.init(x: self.size.width - 200, y: 100)
		node.zPosition = 50
		return node
	}()
	
	lazy var towerTemp40: SKSpriteNode = {
		let node = SKSpriteNode.init(texture: SKTexture.init(imageNamed: "tower40"), color: UIColor.clear, size: CGSize.init(width: 100, height: 100))
		node.position = CGPoint.init(x: self.size.width - 100, y: 100)
		node.zPosition = 50
		return node
	}()
	
	lazy var dragSignNode: DragSignNode = {
		let node = DragSignNode.init(texture: nil, color: UIColor.clear, size: self.size)
		node.isHidden = true
		node.position = CGPoint.zero
		return node
	}()

    private var reuseMonster: Set<MonsterNode> = Set<MonsterNode>()
	private var allMonster: Set<MonsterNode> = Set<MonsterNode>()
	
	private var allTower: Set<TowerNode> = Set<TowerNode>()
	
	private var reuseMissile: Set<MissileBulletNode> = Set<MissileBulletNode>()
	private var allMissile: Set<MissileBulletNode> = Set<MissileBulletNode>()
	
	private var reuseMachineBullet: Set<MachineBulletNode> = Set<MachineBulletNode>()
	private var allMachineBullet: Set<MachineBulletNode> = Set<MachineBulletNode>()
	
	private var reuseIceBullet: Set<IceBulletNode> = Set<IceBulletNode>()
	private var allIceBullet: Set<IceBulletNode> = Set<IceBulletNode>()
	
	private var reuseMissileBombNode: Set<MissileBombNode> = Set<MissileBombNode>()
	
	var searchTestMapTiles: [SKSpriteNode] = [SKSpriteNode]()
	var searchMaps: [[SearchItem]] = [[SearchItem]]()
	
	override init(size: CGSize) {
		super.init(size: size)
		self.physicsWorld.contactDelegate = self
		
		let body = SKPhysicsBody.init(edgeLoopFrom: self.frame)
		body.affectedByGravity = false
		body.allowsRotation = false
		body.usesPreciseCollisionDetection = true
		body.categoryBitMask = BodyType.wall.rawValue
		body.collisionBitMask = BodyType.bullet.rawValue
		body.contactTestBitMask = BodyType.bullet.rawValue
		self.physicsBody = body
			
		NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { [weak self] (noti) in
			self?.pauseGame()
		}
		addChild(audioNode)
		addChild(mapNode)
		addChild(settingBtn)
		addChild(towerTemp10)
		addChild(towerTemp20)
		addChild(towerTemp30)
		addChild(towerTemp40)
		addChild(topNode)
		addChild(dragSignNode)
		addChild(pauseBtn)
		addChild(playBtn)
		addChild(speedBtn)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var upgradeNode: UpgradeNode = {
		let node = UpgradeNode.newNode()
		node.sellTower = { [weak self] (tower) in
			self?.sellTower(tower)
		}
		node.upgradeTower = { [weak self] (tower) in
			self?.upgradeTower(tower)
		}
		node.getCurrentMoney = { [weak self] in self?.money}
		return node
	}()
	
	func playNoneAudio(at point: CGPoint) {
		let node = SKAudioNode.init(fileNamed: "none.wav")
		node.autoplayLooped = false
		node.isPositional = true
		node.position = point
		addChild(node)
		node.run(SKAction.play())
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
			node.removeFromParent()
		}
	}
	
	var isWillSetTower: Bool = false
	
	lazy var nodeArr: [SKSpriteNode] = {
		return [settingBtn, topNode, playBtn, pauseBtn, towerTemp10, towerTemp20, towerTemp30, towerTemp40, speedBtn]
	}()
	
	func willSetTower(type: TowerType) {
		willTowerType = type
		dragSignNode.willSetTower(type: type)
		
		isWillSetTower = true
		canSet = false
	
		for node in nodeArr {
			node.run(SKAction.fadeOut(withDuration: 0.3))
		}
	}
	
	func didSetTower() {
		willTowerType = nil
		isWillSetTower = false
		dragSignNode.didSetTower()
		lastIndexPoint = nil
		canSet = false
		
		for node in nodeArr {
			node.run(SKAction.fadeIn(withDuration: 0.3))
		}
	}
	
    func touchDown(atPoint pos : CGPoint) {
		upgradeNode.removeFromParent()
		if towerTemp10.frame.contains(pos) && money >= 10 {
			willSetTower(type: .machine)
			touchMoved(toPoint: pos)
		} else if towerTemp20.frame.contains(pos) && money >= 10 {
			willSetTower(type: .ice)
			touchMoved(toPoint: pos)
		} else if towerTemp40.frame.contains(pos) && money >= 50 {
			willSetTower(type: .missile)
			touchMoved(toPoint: pos)
		} else if towerTemp30.frame.contains(pos) && money >= 20 {
			willSetTower(type: .magnetic)
			touchMoved(toPoint: pos)
		}
	}
	
	var lastIndexPoint: MapPoint?
	var canSet: Bool = false
	var willTowerType: TowerType?
	
    func touchMoved(toPoint pos : CGPoint) {
		if isWillSetTower {
			let indexPoint = pos.fixToMapPoint()
			if lastIndexPoint?.x != indexPoint.x || lastIndexPoint?.y != indexPoint.y {
				lastIndexPoint = indexPoint;
				let point = pos.fixToMapPositon()
				dragSignNode.setTowerPosition(point)
				canSet = false
				if indexPoint.x >= 0 &&
					indexPoint.x < mapRowCount &&
					indexPoint.y >= 0 &&
					indexPoint.y < mapColumnCount {
					let y = indexPoint.y
					let x = indexPoint.x
					let item = searchMaps[x][y]
					if item.isOpen {
						var nextMaps = [[SearchItem]]()
						for arr in searchMaps {
							var tnextmap = [SearchItem]()
							for mapItem in arr {
								let item = SearchItem()
								item.isOpen = mapItem.isOpen
								item.x = mapItem.x
								item.y = mapItem.y
								tnextmap.append(item)
							}
							nextMaps.append(tnextmap)
						}
						nextMaps[x][y].isOpen = false
						
						let start = SearchItem()
						start.x = 5
						start.y = 0
						let end = SearchItem()
						end.x = 5
						end.y = 22
						let search = Search.init(start: start, end: end, map: nextMaps)
						let arr = search.startSearch()
						if arr.count > 0 {
							canSet = true
						}
					}
				}
				dragSignNode.setIsEnable(canSet)
			}
		}
	}
    
    func touchUp(atPoint pos : CGPoint) {
		if let type = willTowerType, isWillSetTower {
			if let _ = lastIndexPoint, canSet {
				addTower(at: pos, type: type)
			}
			didSetTower()
		}
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
	var time: TimeInterval = 0
	var checkButtleTime: TimeInterval = 0
	
    override func update(_ currentTime: TimeInterval) {
		guard !mapNode.isPaused else {
			return
		}
		if currentTime - time > 2 {
			time = currentTime
            var monster = reuseMonster.first
            if monster == nil {
                let m = MonsterNode.newNode()
				m.maps = { [weak self] in
					return self?.searchMaps
				}
                monster = m
                m.didDie = { [weak self] in
					self?.money = (self?.money ?? 0) + 20
                    self?.reuseMonster.insert(m)
					self?.allMonster.remove(m)
                }
				m.didToEndPoint = { [weak self] in
					self?.reuseMonster.insert(m)
					self?.allMonster.remove(m)
					self?.reduceLife()
				}
            } else {
                monster?.resetNode()
                reuseMonster.removeFirst()
            }
            if let monster = monster {
				monster.type = Int((arc4random() % 10) + 1)
                monster.position =  MapPoint.init(x: 5, y: 0).fixToMapPositon()
                mapNode.addChild(monster)
				allMonster.insert(monster)
                monster.runAnimation()
				monster.startFindPath()
            }
		}

		updateAllTowerState(currentTime)
		updateMissilePath()
		if currentTime - checkButtleTime > 20 {
			checkButtleTime = currentTime
			checkButtle()
		}
    }
	
	func reduceLife() {
		if life > 0 {
			life -= 1
			if life == 0 {
				gameFailure()
			}
		}
	}
}

extension GameScene {
	func restart() {
		initMap()
	}

	func initMap() {
		mapNode.texture = SKTexture.init(imageNamed: mapConfig.mapName)
		money = 20
		life = 30
		totalNum = 30
		currentNum = 1
		
		searchMaps.removeAll()
		for (i, arr) in mapConfig.map.enumerated() {
			var tmap = [SearchItem]()
			for (j, open) in arr.enumerated() {
				let item = SearchItem()
				item.isOpen = (open == 1)
				item.x = i
				item.y = j
				tmap.append(item)
			}
			searchMaps.append(tmap)
		}
		
		//初始化测试地图
		for node in searchTestMapTiles {
			node.removeFromParent()
		}
		searchTestMapTiles.removeAll()
		for (i, arr) in mapConfig.map.enumerated() {
			for (j, open) in arr.enumerated() {
				if open == 0 {
					let node = SKSpriteNode.init(color: UIColor.red.withAlphaComponent(0.5), size: CGSize.init(width: itemWidth, height: itemHeight))
					node.position = MapPoint.init(x: i, y: j).fixToMapPositon()
					node.zPosition = 20
					addChild(node)
					searchTestMapTiles.append(node)
				}
			}
		}

		for node in reuseMonster {
			node.removeFromParent()
		}
		reuseMonster.removeAll()
		
		for node in allMonster {
			node.removeFromParent()
		}
		allMonster.removeAll()
		
		for node in allTower {
			node.removeFromParent()
		}
		allTower.removeAll()
		
		resumeGame()
		
		reuseMachineBullet.insert(MachineBulletNode.newNode())
		
		test()
	}
}

extension GameScene: SKPhysicsContactDelegate {
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else {
			return
		}
		var monster: MonsterNode?
		var bullet: (BulletProtocol & SKNode)?
		
		if (nodeA is MonsterNode) {
			monster = nodeA as? MonsterNode
		}
		if (nodeB is MonsterNode) {
			monster = nodeB as? MonsterNode
		}
		if nodeA is (BulletProtocol & SKNode) {
			bullet = nodeA as? (BulletProtocol & SKNode)
		}
		if nodeB is (BulletProtocol & SKNode) {
			bullet = nodeB as? (BulletProtocol & SKNode)
		}

		let handleButtle: (((BulletProtocol & SKNode)?) -> Void) = { (bullet) in
			if let node = (bullet as? MissileBulletNode) {
				self.allMissile.remove(node)
				self.reuseMissile.insert(node)
				self.addMissileBombEffect(atPoint: contact.contactPoint)
			} else if let node = (bullet as? MachineBulletNode) {
				self.allMachineBullet.remove(node)
				self.reuseMachineBullet.insert(node)
			} else if let node = (bullet as? IceBulletNode) {
				self.allIceBullet.remove(node)
				self.reuseIceBullet.insert(node)
			}
			bullet?.removeFromParent()
		}
		
		guard let m = monster, let b = bullet else {
			handleButtle(bullet)
			return
		}

		m.reduceBlood(b.atk)
		if let _ = (bullet as? IceBulletNode) {
			m.addIceEffect()
		}
		if b.contactIsRemove {
			handleButtle(b)
		}
	}
}

extension GameScene {
	
	/// 怪物重新算路
	func refreshRoute(towerPoint: CGPoint, isForce: Bool) {
		let indexPoint = towerPoint.fixToMapPoint()
		allMonster.forEach { (monster) in
			if isForce {
				monster.startFindPath()
			} else {
				monster.startFindPath(for: indexPoint)
			}
		}
	}
	
	/// 更新塔状态
	func updateAllTowerState(_ currentTime: TimeInterval) {
		DispatchQueue.global().async { [allTower] in
			allTower.forEach { (tower) in
				tower.update(currentTime)
			}
		}
	}
	
	/// 更新导弹位置
	func updateMissilePath() {
		DispatchQueue.global().async { [allMissile] in
			allMissile.forEach { (missile) in
				if let monster = missile.monster, monster.parent != nil {
					missile.zRotation = missile.position.angle(to: monster.position)
					let dx = monster.position.x - missile.position.x
					let dy = monster.position.y - missile.position.y
					let dis = monster.position.distance(to: missile.position)
					let ndx = missile.flySpeed * dx / dis
					let ndy = missile.flySpeed * dy / dis
					missile.physicsBody?.velocity = CGVector.init(dx: ndx, dy: ndy)
				}
			}
		}
	}
	
	/// 添加导弹爆炸效果
	func addMissileBombEffect(atPoint: CGPoint) {
		var missileBombNode: MissileBombNode!
		if let one = reuseMissileBombNode.first {
			missileBombNode = one
			reuseMissileBombNode.remove(one)
		} else {
			missileBombNode = MissileBombNode.newNode()
		}
		missileBombNode.position = atPoint
		mapNode.addChild(missileBombNode)
		missileBombNode.runAnimation(comleted: {
			missileBombNode.removeFromParent()
			self.reuseMissileBombNode.insert(missileBombNode)
		})
	}
	
	/// 添加塔
	func addTower(at point: CGPoint, type: TowerType) {
		let indexPoint = point.fixToMapPoint()
		if indexPoint.x >= 0 &&
			indexPoint.x < mapRowCount &&
			indexPoint.y >= 0 &&
			indexPoint.y < mapColumnCount {
			let y = indexPoint.y
			let x = indexPoint.x
			let item = searchMaps[x][y]
			if item.isOpen {
				item.isOpen = false
				let tower = TowerNode.newNode(type: type)
				tower.clickAction = { [weak self] (node) in
					self?.showConfig(for: node as? TowerNode)
				}
				tower.attackAction = { [weak self] (tower, monster) in
					guard let monster = monster else { return }
					if tower.type == .machine {
						self?.sendMachineBullet(tower: tower, monster: monster)
					} else if tower.type == .missile {
						self?.sendMissileBullet(tower: tower, monster: monster)
					} else if tower.type == .ice {
						self?.sendIceBullet(tower: tower, monster: monster)
					} else {
						self?.sendMagneticBullet(tower: tower, monster: monster)
					}
				}
				tower.position = point.fixToMapPositon()
				tower.getAllMonster = { self.allMonster }
				mapNode.addChild(tower)
				allTower.insert(tower)
				money -= 10
				refreshRoute(towerPoint: point, isForce: false)
			} else {
				playNoneAudio(at: point)
			}
		} else {
			playNoneAudio(at: point)
		}
	}
	
	/// 出售塔
	func sellTower(_ tower: TowerNode?) {
		guard let tower = tower else {
			return
		}
		let indexPoint = tower.position.fixToMapPoint()
		if indexPoint.x >= 0 &&
			indexPoint.x < mapRowCount &&
			indexPoint.y >= 0 &&
			indexPoint.y < mapColumnCount {
			let y = indexPoint.y
			let x = indexPoint.x
			let item = searchMaps[x][y]
			item.isOpen = true
			allTower.remove(tower)
			tower.lightningNode.isHidden = true
			tower.removeAllActions()
			tower.removeFromParent()
			refreshRoute(towerPoint: CGPoint.zero, isForce: true)
		} else {
			assert(false, "不应该出现")
		}
	}
	
	/// 升级塔
	func upgradeTower(_ tower: TowerNode?) {
		guard let tower = tower else {
			return
		}
		tower.upgrade()
	}
	
	/// 显示塔升级/移除配置
	func showConfig(for tower: TowerNode?) {
		guard let tower = tower else {
			return
		}
		upgradeNode.removeFromParent()
		upgradeNode.position = tower.position
		upgradeNode.setData(tower: tower)
		mapNode.addChild(upgradeNode)
	}
	
	/// 发射普通子弹
	func sendMachineBullet(tower: TowerNode, monster: MonsterNode) {
		var node: MachineBulletNode!
		if let temp = reuseMachineBullet.first {
			node = temp
			reuseMachineBullet.remove(temp)
		} else {
			node = MachineBulletNode.newNode()
		}
		allMachineBullet.insert(node)
		node.removeAllActions()
		node.runAnimation()
		node.atk = tower.config.atkValue
		node.position = tower.position
		mapNode.addChild(node)
		
		let dx = monster.position.x - tower.position.x
		let dy = monster.position.y - tower.position.y
		let dis = monster.position.distance(to: tower.position)
		let ndx = node.flySpeed * dx / dis
		let ndy = node.flySpeed * dy / dis
		node.physicsBody?.velocity = CGVector.init(dx: ndx, dy: ndy)
	}
	
	/// 发送减速子弹
	func sendIceBullet(tower: TowerNode, monster: MonsterNode) {
		var node: IceBulletNode!
		if let temp = reuseIceBullet.first {
			node = temp
			reuseIceBullet.remove(temp)
		} else {
			node = IceBulletNode.newNode()
		}
		allIceBullet.insert(node)
		node.removeAllActions()
		node.runAnimation()
		node.atk = tower.config.atkValue
		node.position = tower.position
		node.zRotation = tower.bodyNode.zRotation
		mapNode.addChild(node)
		
		let dx = monster.position.x - tower.position.x
		let dy = monster.position.y - tower.position.y
		let dis = monster.position.distance(to: tower.position)
		let ndx = node.flySpeed * dx / dis
		let ndy = node.flySpeed * dy / dis
		node.physicsBody?.velocity = CGVector.init(dx: ndx, dy: ndy)
	}
	
	/// 发送导弹
	func sendMissileBullet(tower: TowerNode, monster: MonsterNode) {
		var node: MissileBulletNode!
		if let temp = reuseMissile.first {
			node = temp
			reuseMissile.remove(temp)
		} else {
			node = MissileBulletNode.newNode()
		}
		allMissile.insert(node)
		node.removeAllActions()
		node.runAnimation()
		node.monster = tower.currentMonster
		node.atk = tower.config.atkValue
		node.position = tower.position
		node.zRotation = tower.bodyNode.zRotation
		mapNode.addChild(node)
	}
	
	/// 发送闪电子弹
	func sendMagneticBullet(tower: TowerNode, monster: MonsterNode) {
		monster.reduceBlood(tower.config.atkValue)
	}
	
	/// 检查子弹状态
	func checkButtle() {
		let temp = allMachineBullet
		for buttle in temp {
			if !mapNode.frame.contains(buttle.position) {
				allMachineBullet.remove(buttle)
				reuseMachineBullet.insert(buttle)
				buttle.removeFromParent()
				print("allMachineBullet 碰撞失败\(buttle)")
			}
		}
		let temp1 = allIceBullet
		for buttle in temp1 {
			if !mapNode.frame.contains(buttle.position) {
				allIceBullet.remove(buttle)
				reuseIceBullet.insert(buttle)
				buttle.removeFromParent()
				print("allMachineBullet 碰撞失败\(buttle)")
			}
		}
	}
	
	
	func test() {
//		DispatchQueue.global().async { [weak self] in
//			var flag = false
//			for i in [3, 5, 7, 9, 11, 13, 15, 17, 19, 21] {
//				for j in 0...10 {
//					Thread.sleep(forTimeInterval: 0.1)
//					DispatchQueue.main.async {
//						if (flag && j != 0) || (!flag && j != 10) {
//							let type = TowerType.init(rawValue: Int(arc4random() % 4))
//							self?.addTower(at: CGPoint.init(x: i * 50, y: 75 + j * 50), type: type ?? .missile)
//						}
//						if j == 10 {
//							flag = !flag
//						}
//					}
//				}
//			}
//		}
	}
}
