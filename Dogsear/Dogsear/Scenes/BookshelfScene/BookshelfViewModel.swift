//
//  BookshelfViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import Foundation

class BookshelfViewModel {
    let firebaseManager = FirebaseManager()
    var originPostBooks: [PostBook] = []
    let postBooks: Observable<[PostBook]> = Observable([])
}
