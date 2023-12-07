//
//  PostBookComment.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/4/23.
//

import Foundation

struct PostBookComment: Codable {
    let id: String
    let bookComment: String
    let myComment: String
    let date: Date
}
