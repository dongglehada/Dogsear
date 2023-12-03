//
//  SignUpViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/2/23.
//

import Foundation
import FirebaseAuth

enum ValidationResult {
    case empty
    case checking
    case available
    case alreadyInUse
    case unavailableFormat
    case length
    case combination
    case special
    case unconformity
}

class SignUpViewModel {
    // MARK: - Property

    let emailState: Observable<ValidationResult> = Observable(.empty)
    
    let nickNameState: Observable<ValidationResult> = Observable(.empty)
    
    let passwordState: Observable<ValidationResult> = Observable(.empty)
    
    let checkPasswordState: Observable<ValidationResult> = Observable(.empty)
    
    let isPrivacyAgree: Observable<Bool> = Observable(false)
    let isSignUpAble: Observable<Bool> = Observable(false)
}

extension SignUpViewModel {
    // MARK: - Method
    func trySignUp(email: String, password: String, completion: @escaping (_ isSuccess: Bool) -> Void ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func isValidEmail(email: String) {
        if email.count == 0 {
            emailState.value = .empty
            return
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: email) {
            emailState.value = .checking
//            loginManager.isAvailableEmail(email: email) { [weak self] state in
//                if state {
//                    self?.emailState.value = .available
//                } else{
//                    self?.emailState.value = .alreadyInUse
//                }
//            }
        } else {
            emailState.value = .unavailableFormat
        }
    }
    
    func isValidNickName(nickName: String) {
        if nickName.count == 0 {
            nickNameState.value = .empty
            return
        }
        if (2 ... 8).contains(nickName.count) {
            nickNameState.value = .available
        } else {
            nickNameState.value = .length
        }
    }
    
    func isValidPassword(password: String) {
        if password.count == 0 {
            passwordState.value = .empty
            return
        }
        let lengthreg = ".{8,20}"
        let lengthtesting = NSPredicate(format: "SELF MATCHES %@", lengthreg)
        if lengthtesting.evaluate(with: password) == false {
            passwordState.value = .length
            return
        }
        let combinationreg = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"
        let combinationtesting = NSPredicate(format: "SELF MATCHES %@", combinationreg)
        if combinationtesting.evaluate(with: password) == false {
            passwordState.value = .combination
            return
        }
        let specialreg = "^(?=.*[!@#$%^&*()_+=-]).{8,20}"
        let specialtesting = NSPredicate(format: "SELF MATCHES %@", specialreg)
        if specialtesting.evaluate(with: password) == false {
            passwordState.value = .special
            return
        }
        passwordState.value = .available
    }
    
    func isCheckPassword(password: String, checkPassword: String) {
        if password.count == 0 {
            checkPasswordState.value = .empty
            return
        }
        if password == checkPassword {
            checkPasswordState.value = .available
        } else {
            checkPasswordState.value = .unconformity
        }
    }
}
