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

class FirebaseManager {
    
    private let db = Firestore.firestore()
    private let users: String = "users"
    
    func uploadImage(image: UIImage, pathRoot: String, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
        
        let firebaseReference = Storage.storage().reference().child("\(imageName)")
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, _ in
                completion(url)
            }
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
    
}
