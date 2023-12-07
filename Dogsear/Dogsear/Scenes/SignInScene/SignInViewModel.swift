//
//  SignViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import Foundation
import FirebaseAuth

enum SignInResult {
    case emptyEmail
    case emptyPassword
    case fail
    case success
}

class SignInViewModel {
    
    let userDefaultManager = UserDefaultsManager()
    let isAutoLogin: Observable<Bool> = Observable(false)
    
    func trySignIn(email: String, password: String, completion: @escaping (SignInResult) -> Void) {
        if email == "" {
            completion(.emptyEmail)
            return
        }
        if password == "" {
            completion(.emptyPassword)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if error == nil {
                completion(.success)
            } else {
                completion(.fail)
            }
        }
    }
    

}
