//
//  KeyboardFollower.swift
//  Kuchi
//
//  Created by admin on 2021/1/29.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import UIKit

final class KeyboardFollower: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    func subscribe() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardVisibilityChanged), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    func unsubscribe() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc func keyboardVisibilityChanged(_ notification: Notification){
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardBeginFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else { return }
        guard let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let visible = keyboardBeginFrame.minY > keyboardEndFrame.minY
        keyboardHeight = visible ? keyboardEndFrame.height : 0
        
    }
}
