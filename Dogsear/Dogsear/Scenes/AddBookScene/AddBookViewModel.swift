//
//  AddBookViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import Foundation

class AddBookViewModel {
    
    var firebaseManager = FirebaseManager()
    var newPost: Observable<PostBook> = Observable(
        PostBook(
            id: String.getNewID(type: .bookPost),
            imageUrl: URL(string: ""),
            title: "",
            author: "",
            publisher: "",
            state: .reading,
            comments: []
        )
    )
}
