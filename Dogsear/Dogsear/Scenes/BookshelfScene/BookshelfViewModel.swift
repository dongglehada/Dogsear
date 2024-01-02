//
//  BookshelfViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import Foundation

class BookshelfViewModel {
    var firebaseManager = FirebaseManager()
    var originPostBooks: [PostBook] = []
    var postBooks: Observable<[PostBook]> = Observable([])
}
