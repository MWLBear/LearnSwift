//
//  UserManager.swift
//  Kuchi
//
//  Created by admin on 2021/1/29.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import Combine
import SwiftUI
import Foundation

final class UserManger: ObservableObject {
    @Published
    var profile: Profile = Profile()
    
    @Published
    var settings: Settings = Settings()
    
    var isRegister: Bool {
        return profile.name.isEmpty == false
    }
    
    init() {
        
    }
    
    init(name: String) {
        self.profile.name = name
    }
    
    func persistProfile() {
        if settings.remenberUser {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(profile), forKey: "user-profile")
        }
    }
    
    func persistSettings() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey: "user-settings")
    }
    
    func load() {
        
        if let data = UserDefaults.standard.value(forKey: "user-profile") as? Data {
            if let profile = try? PropertyListDecoder().decode(Profile.self, from: data) {
                self.profile = profile
            }
        }
        
        if let data = UserDefaults.standard.value(forKey: "user-settings") as? Data {
            if let profile = try? PropertyListDecoder().decode(Settings.self, from: data) {
                self.settings = profile
            }
        }
        
        
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: "user-profile")
    }
    
    func isUserNameValid() -> Bool {
        return profile.name.count >= 3
    }
}
