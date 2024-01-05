//
//  BookDetailViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation

enum CommentState {
    case myComment
    case bookComment
    case both
}

class BookDetailViewModel {
    // MARK: - Property
    var firebaseManager = FirebaseManager()
    var postData: Observable<PostBook>
    var isEdit: Observable<Bool> = Observable(false)
    
    init(postData: Observable<PostBook>) {
        self.postData = postData
    }
    
    // MARK: - Method
    func fetchPostData(completion: @escaping () -> Void) {
        firebaseManager.fetchUserData { user in
            guard let index = user.PostBooks.firstIndex(where: {$0.id == self.postData.value?.id}) else { return }
            self.postData.value = user.PostBooks[index]
            completion()
        }
    }
    
    func getCommentState(comment: PostBookComment) -> CommentState{
        if !comment.bookComment.isEmpty && !comment.myComment.isEmpty {
            return .both
        } else {
            if comment.bookComment.isEmpty {
                return .myComment
            } else {
                return .bookComment
            }
        }
    }
}

