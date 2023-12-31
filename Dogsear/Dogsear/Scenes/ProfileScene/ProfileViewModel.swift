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
    var firebaseManager = FirebaseManager()
    var settingItems:[SettingItem] = [
        SettingItem(title: "폰트 크기 설정", iamge: UIImage(systemName: "character.cursor.ibeam")),
        SettingItem(title: "개인정보처리방침", iamge: UIImage(systemName: "hand.raised")),
        SettingItem(title: "로그아웃", iamge: UIImage(systemName: "lock.open")),
        SettingItem(title: "회원탈퇴", iamge: UIImage(systemName: "person.fill.xmark"))
    ]
}
