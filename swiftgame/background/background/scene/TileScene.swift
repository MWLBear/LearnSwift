//
//  TileScene.swift
//  background
//
//  Created by admin on 2021/11/25.
//

import SpriteKit
import UIKit

class TileScene: SKScene, UITextFieldDelegate {
    var highScoreText: UITextField!
    let submitScoreText = SKLabelNode(fontNamed: "arial")

    override func didMove(to view: SKView) {
        print("didMove to")
        highScoreText = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 20, width: 320, height: 40))

        view.addSubview(highScoreText)
        highScoreText.delegate = self
        highScoreText.borderStyle = .roundedRect
        highScoreText.textColor = .black
        highScoreText.placeholder = "Enter your name here"
        highScoreText.backgroundColor = SKColor.white
        highScoreText.autocorrectionType = .default

        highScoreText.clearButtonMode = .whileEditing
        highScoreText.autocapitalizationType = .allCharacters
        self.view!.addSubview(highScoreText)

        submitScoreText.fontSize = 22
        submitScoreText.position = CGPoint(x: 110, y: 110)
        submitScoreText.text = "your text will show here"
        addChild(submitScoreText)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submitScoreText.text = textField.text
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highScoreText.resignFirstResponder()
    }
}
