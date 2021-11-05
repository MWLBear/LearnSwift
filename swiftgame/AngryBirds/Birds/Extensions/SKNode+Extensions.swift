//
//  SKNode+Extensions.swift
//  Birds
//
//  Created by Roman Yakovliev on 18.10.2021.
//

import SpriteKit

extension SKNode {
    
    func aspectScale(to size: CGSize, width: Bool, multiplier: CGFloat) {
        let scale = width ? (size.width * multiplier) / self.frame.width : (size.height * multiplier) / self.frame.size.height
        self.setScale(scale)
    }
    
}
