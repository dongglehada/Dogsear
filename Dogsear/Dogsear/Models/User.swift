//
//  User.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/4/23.
//

import Foundation

struct User: Codable {
    let email: String
    var nickName: String
    var PostBooks: [PostBook]
}
