//
//  BookshelfViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import Foundation

protocol BookshelfViewModelProtocol {
    var firebaseManager: FirebaseManager { get set }
    var originPostBooks: [PostBook] { get set }
    var postBooks: Observable<[PostBook]> { get set }
}

class BookshelfViewModel: BookshelfViewModelProtocol {
    var firebaseManager = FirebaseManager()
    var originPostBooks: [PostBook] = []
    var postBooks: Observable<[PostBook]> = Observable([])
}
