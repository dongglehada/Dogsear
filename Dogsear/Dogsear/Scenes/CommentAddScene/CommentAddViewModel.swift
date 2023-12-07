//
//  CommentViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation

class CommentAddViewModel {
    let firebaseManager = FirebaseManager()
    var postID: String?
    
    init(postID: String?) {
        self.postID = postID
    }
}

extension CommentAddViewModel {
    
    func isVaildCommet(bookText: String, myText: String) -> Bool {
        if !bookText.isEmpty && !myText.isEmpty {
            return true
        }
        return false
    }
    
    func makeCommentPost(bookText: String, myText: String, completion: @escaping () -> Void) {
        let newComment = PostBookComment(
            id: String.getNewID(type: .comment),
            bookComment: bookText,
            myComment: myText,
            date: Date())
        self.firebaseManager.createNewComment(postID: self.postID ?? "", newComment: newComment, completion: {
            completion()
        })
    }
}
