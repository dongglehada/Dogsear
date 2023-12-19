//
//  BookDetailViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation

protocol BookDetailViewModelProtocol {
    var firebaseManager: FirebaseManager { get set }
    var postData: Observable<PostBook> { get set }
    var isEdit: Observable<Bool> { get set }
    func fetchPostData(completion: @escaping () -> Void)
}

class BookDetailViewModel: BookDetailViewModelProtocol {
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
}

