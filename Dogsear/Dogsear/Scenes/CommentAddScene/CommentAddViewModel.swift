//
//  CommentViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation

class CommentAddViewModel {
    // MARK: - Property
    var firebaseManager = FirebaseManager()
    var postID: String
    var comment: PostBookComment?
    var isEditPost = false
    
    init(postID: String, comment: PostBookComment?) {
        self.postID = postID
        self.comment = comment
    }
    // MARK: - Method
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
        self.firebaseManager.createComment(postID: self.postID, newComment: newComment, completion: {
            completion()
        })
    }
}
