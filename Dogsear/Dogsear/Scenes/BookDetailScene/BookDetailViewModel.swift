//
//  BookDetailViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation

protocol BookDetailViewModelProtocol {
    func fetchPostData(completion: @escaping () -> Void)
}

class BookDetailViewModel {
    let firebaseManager = FirebaseManager()
    let postData: Observable<PostBook>
    let isEdit: Observable<Bool> = Observable(false)
    
    init(postData: Observable<PostBook>) {
        self.postData = postData
    }
}
extension BookDetailViewModel: BookDetailViewModelProtocol {
    func fetchPostData(completion: @escaping () -> Void) {
        firebaseManager.fetchUserData { user in
            guard let index = user.PostBooks.firstIndex(where: {$0.id == self.postData.value?.id}) else { return }
            self.postData.value = user.PostBooks[index]
            completion()
        }
    }
}
