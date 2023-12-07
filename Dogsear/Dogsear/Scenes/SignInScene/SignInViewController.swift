//
//  SignInViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import Foundation
import UIKit
import FirebaseAuth

class SignInViewController: BasicController<SignInViewModel,SignInView> {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
    }
}

private extension SignInViewController {
    // MARK: - SetUp
    func setUp() {
        sceneView.signInButton.button.addTarget(self, action: #selector(didTapSignInButton), for: .primaryActionTriggered)
        sceneView.signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .primaryActionTriggered)
        sceneView.autoLoginButton.addAction(UIAction(handler: { _ in self.didTapAutoLoginButton() }), for: .primaryActionTriggered)
    }
    
    func bind() {
        viewModel?.isAutoLogin.bind({ [weak self] state in
            guard let state = state else { return }
            self?.viewModel?.userDefaultManager.setAutoLogin(toggle: state)
            if state {
                self?.sceneView.autoLoginButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            } else {
                self?.sceneView.autoLoginButton.setImage(UIImage(systemName: "square"), for: .normal)
            }
        })
    }
}

extension SignInViewController {
    // MARK: - Method
    
    @objc func didTapSignUpButton() {
        let vc = SignUpViewController()
        vc.viewInjection(sceneView: SignUpView())
        vc.viewModelInjection(viewModel: SignUpViewModel())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapAutoLoginButton() {
        self.viewModel?.isAutoLogin.value?.toggle()
    }
    
    
    @objc func didTapSignInButton() {
        
        guard let email = sceneView?.emailTextField.textField.text else { return }
        guard let password = sceneView?.passwordTextField.textField.text else { return }
        
        self.startIndicatorAnimation()
        
        viewModel?.trySignIn(email: email, password: password, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .emptyEmail:
                sceneView?.missMatchLabelShow(isShow: true, content: "이메일을 입력해 주세요.")
            case .emptyPassword:
                sceneView?.missMatchLabelShow(isShow: true, content: "패스워드를 입력해 주세요.")
            case .fail:
                self.sceneView?.missMatchLabelShow(isShow: true, content: "이메일 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.")
            case .success:
                self.sceneView?.missMatchLabelShow(isShow: false, content: nil)
                let rootView = MyCustomTabBarController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(viewController: rootView, animated: false)
            }
            self.stopIndicatorAnimation()
        })
        
    }
}
