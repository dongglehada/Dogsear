//
//  PostBook.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/2/23.
//

import Foundation

struct PostBook: Codable {
    var imageUrl: String
    var title: String
    var author: String
    var publisher: String
    var state: PostBookState
    var comments: [PostBookComment]
}

enum PostBookState: Codable {
    case reading
    case complete
    case expected
}
