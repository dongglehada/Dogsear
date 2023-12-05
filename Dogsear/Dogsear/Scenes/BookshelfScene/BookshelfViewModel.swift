//
//  BookshelfViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import Foundation

class BookshelfViewModel {
    let firebaseManager = FirebaseManager()
    let postBooks: Observable<[PostBook]> = Observable([])
}
