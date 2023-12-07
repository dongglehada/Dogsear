//
//  UserDefaultsManager.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/8/23.
//

import Foundation

struct UserDefaultsManager {
    
    private let defaults = UserDefaults.standard
    private let isAutoLogin = "isAutoLogin"
    
    func setAutoLogin(toggle:Bool) {
        defaults.set(toggle, forKey: isAutoLogin)
    }
    
    func getIsAutoLogin() -> Bool {
        return defaults.bool(forKey: isAutoLogin)
    }
}
