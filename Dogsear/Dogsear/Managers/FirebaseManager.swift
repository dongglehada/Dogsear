//
//  FirebaseManager.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import Foundation
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class FirebaseManager {
    
    private let db = Firestore.firestore()
    private let users: String = "users"
    private let PostBooks: String = "PostBooks"
    let email = Auth.auth().currentUser?.email
    
    func deleteUser(email: String, completion: @escaping () -> Void) {
        db.collection(users).document(email).delete { error in
            Auth.auth().currentUser?.delete(completion: { error in
                completion()
            })
        }
    }
    
    func logOut(completion: @escaping (_ isLogOut: Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
        }
        
    }
    
    func createUser(email: String, nickName: String, completion: @escaping (_ isSuccess: Bool, _ errorMessage: String?) -> Void) {
        
        let userData = User(email: email, nickName: nickName, PostBooks: [])
        do {
            let data = try Firestore.Encoder().encode(userData)
            db.collection(users).document(email).setData(data)
            completion(true, nil)
        } catch {
            completion(false,"FirebaseManager_EncodeFail")
        }
    }
    
    func createBookPost(newPost: PostBook, completion: @escaping () -> Void) {
        guard let email = email else { return }
        fetchUserData() { user in
            var user = user
            user.PostBooks.append(newPost)
            do {
                let data = try Firestore.Encoder().encode(user)
                self.db.collection(self.users).document(email).updateData(data)
                completion()
            } catch {
                print("[FirebaseManager][\(#function)]:Fail")
                completion()
            }
        }
    }
    
    func deleteBookPost(target: PostBook, completion: @escaping () -> Void) {
        guard let email = email else { return }
        fetchUserData() { user in
            var user = user
            guard let index = user.PostBooks.firstIndex(where: {$0.id == target.id}) else { return }
            user.PostBooks.remove(at: index)
            do {
                let data = try Firestore.Encoder().encode(user)
                self.db.collection(self.users).document(email).updateData(data)
                completion()
            } catch {
                print("[FirebaseManager][\(#function)]:Fail")
                completion()
            }
        }
    }
    
    func updateBookPost(postBook: PostBook, completion: @escaping () -> Void) {
        guard let email = email else { return }
        fetchUserData() { user in
            var user = user
            guard let index = user.PostBooks.firstIndex(where: {$0.id == postBook.id}) else { return }
            user.PostBooks[index] = postBook
            do {
                let data = try Firestore.Encoder().encode(user)
                self.db.collection(self.users).document(email).updateData(data)
                completion()
            } catch {
                print("[FirebaseManager][\(#function)]:Fail")
                completion()
            }
        }
    }
    
    func fetchUserData(completion: @escaping (User) -> Void) {
        guard let email = email else { return }
        db.collection(users).document(email).getDocument { data, error in
            if error != nil {
                print("[FirebaseManager][\(#function)]: \(String(describing: error?.localizedDescription))")
            } else {
                guard let data = data?.data() else { return }
                do {
                    let safeData = try Firestore.Decoder().decode(User.self, from: data)
                    completion(safeData)
                } catch {
                    print("[FirebaseManager][\(#function)]: DecodingFail")
                }
            }
        }
    }
    
    func createComment(postID: String, newComment: PostBookComment, completion: @escaping () -> Void) {
        guard let email = email else { return }
        fetchUserData() { user in
            var user = user
            guard let index = user.PostBooks.firstIndex(where: {$0.id == postID}) else { return }
            user.PostBooks[index].comments.append(newComment)
            do {
                let data = try Firestore.Encoder().encode(user)
                self.db.collection(self.users).document(email).updateData(data)
                completion()
            } catch {
                print("[FirebaseManager][\(#function)]:Fail")
                completion()
            }
        }
    }
    
    func deleteComment(postID: String, commentID: String, completion: @escaping () -> Void) {
        guard let email = email else { return }
        fetchUserData() { user in
            var user = user
            guard let postIndex = user.PostBooks.firstIndex(where: {$0.id == postID}) else { return }
            guard let commentIndex = user.PostBooks[postIndex].comments.firstIndex(where: {$0.id == commentID}) else { return }
            user.PostBooks[postIndex].comments.remove(at: commentIndex)
            do {
                let data = try Firestore.Encoder().encode(user)
                self.db.collection(self.users).document(email).updateData(data)
                completion()
            } catch {
                print("[FirebaseManager][\(#function)]:Fail")
                completion()
            }
        }
    }
    
    func updateComment(postID: String, updateComment: PostBookComment, completion: @escaping () -> Void) {
        guard let email = email else { return }
        fetchUserData() { user in
            var user = user
            guard let postIndex = user.PostBooks.firstIndex(where: {$0.id == postID}) else { return }
            guard let commentIndex = user.PostBooks[postIndex].comments.firstIndex(where: {$0.id == updateComment.id}) else { return }
            user.PostBooks[postIndex].comments[commentIndex] = updateComment
            do {
                let data = try Firestore.Encoder().encode(user)
                self.db.collection(self.users).document(email).updateData(data)
                completion()
            } catch {
                print("[FirebaseManager][\(#function)]:Fail")
                completion()
            }
        }
    }
}

extension FirebaseManager {
    // MARK: - StorageMethod
    func uploadImage(image: UIImage?, completion: @escaping (URL?) -> Void) {
        guard let image = image else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let imageName = String.getNewID(type: .imageUrl)
        
        let firebaseReference = Storage.storage().reference().child("\(imageName)")
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, _ in
                completion(url)
            }
        }
    }
}
