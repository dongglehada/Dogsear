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
        sceneView?.passwordTextField.showButton.addTarget(self, action: #selector(didTapShowButton), for: .touchUpInside)
        sceneView?.signInButton.button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        sceneView?.activityIndicator.center = view.center
    }

    // MARK: - Bind
    func bind() {
        viewModel?.isShow.bind({ [weak self] state in
            guard let self = self else { return }
            guard let state = state else { return }
            self.sceneView?.passwordTextField.changeShowButtonColor(state: state)
        })
    }
}

extension SignInViewController {
    // MARK: - Method
    @objc func didTapShowButton() {
        viewModel?.isShow.value?.toggle()
    }
    
    @objc func didTapSignInButton() {
        
        guard let email = sceneView?.emailTextField.textField.text else { return }
        guard let password = sceneView?.passwordTextField.textField.text else { return }
        
        sceneView?.activityIndicator.startAnimating()
        
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
                let rootVC = BookshelfViewController()
                rootVC.viewInjection(sceneView: BookshelfView())
                rootVC.viewModelInjection(viewModel: BookshelfViewModel())
                navigationController?.pushViewController(rootVC, animated: true)
            }
            self.sceneView?.activityIndicator.stopAnimating()
        })
        
    }
}
