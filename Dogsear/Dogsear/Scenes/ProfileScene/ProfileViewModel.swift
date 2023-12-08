//
//  ProfileViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/5/23.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileViewModel {
    let firebaseManager = FirebaseManager()
    let settingItems:[SettingItem] = [
        SettingItem(title: "개인정보처리방침", iamge: UIImage(systemName: "hand.raised")),
        SettingItem(title: "로그아웃", iamge: UIImage(systemName: "lock.open")),
        SettingItem(title: "회원탈퇴", iamge: UIImage(systemName: "person.fill.xmark"))
    ]
}
