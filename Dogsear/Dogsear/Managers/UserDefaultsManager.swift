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
    private let bookFont = "isBookFont"
    private let myFont = "isMyFont"
    private let viewType = "viewType"
    
    func setAutoLogin(toggle:Bool) {
        defaults.set(toggle, forKey: isAutoLogin)
    }
    
    func getIsAutoLogin() -> Bool {
        return defaults.bool(forKey: isAutoLogin)
    }
    
    func setBookFontSize(value: Double) {
        defaults.set(value, forKey: bookFont)
    }
    
    func setIsListView(value: Bool) {
        defaults.set(value, forKey: viewType)
    }
    
    func getIsListView() -> Bool{
        return defaults.bool(forKey: viewType)
    }
    static func getBookFontSize() -> Double {
        return UserDefaults.standard.double(forKey: "isBookFont")
    }
    
    func setMyFontSize(value: Double) {
        defaults.set(value, forKey: myFont)
    }
    
    static func getMyFontSize() -> Double {
        return UserDefaults.standard.double(forKey: "isMyFont")
    }
    
    
}
