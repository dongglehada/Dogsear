//
//  PostBookComment.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/4/23.
//

import Foundation

struct PostBookComment: Codable {
    let id: String
    let comment: String
    let page: Int
    let date: Date
    let imageURL: URL?
}
