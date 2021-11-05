//
//  MenuScene.swift
//  Birds
//
//  Created by Roman Yakovliev on 18.10.2021.
//

import SpriteKit

class MenuScene: SKScene {
    
    var SceneManagerDelegate: SceneManagerDelegate?
    
    override func didMove(to view: SKView) {
        setupMenu()
    }
    
    func setupMenu() {
        let button = SpriteKitButton(defaultButtonImage: "playButton", action: goToLevelScene, index: 0)
        button.position = CGPoint(x: frame.midX, y: frame.midY)
        button.aspectScale(to: frame.size, width: false, multiplier: 0.2)
        addChild(button)
    }
    
    func goToLevelScene(_: Int) {
        SceneManagerDelegate?.presentLevelScene()
    }

}
