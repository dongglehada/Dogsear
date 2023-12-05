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
    private let email = Auth.auth().currentUser?.email
    
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
    
    func creatNewBookPost(newPost: PostBook, completion: @escaping () -> Void) {
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
    
    func fetchUserData(completion: @escaping (User) -> Void) {
        guard let email = email else { return }
        db.collection(users).document(email).getDocument { data, error in
            if error != nil {
                print("[FirebaseManager][\(#function)]: \(String(describing: error?.localizedDescription))")
            } else {
                guard let data = data?.data() else { return }
                do {
                    var safeData = try Firestore.Decoder().decode(User.self, from: data)
                    completion(safeData)
                } catch {
                    print("[FirebaseManager][\(#function)]: DecodingFail")
                }
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
