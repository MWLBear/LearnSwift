//
//  TimeCounter.swift
//  RGBullsEye
//
//  Created by admin on 2021/1/14.
//

import Foundation
import Combine

class TimeCounter: ObservableObject {
    let objectWillChange = PassthroughSubject<TimeCounter, Never>()
    var timer: Timer?
    var counter = 0
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        counter += 1
        objectWillChange.send(self)
    }
    
    func killTimer() {
        timer?.invalidate()
        timer = nil
    }
}
