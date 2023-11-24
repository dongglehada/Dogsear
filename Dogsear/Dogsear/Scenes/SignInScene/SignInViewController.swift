//
//  SignInViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import Foundation

class SignInViewController: BasicController<SignInViewModel,SignInView> {
    // MARK: - Property
}
extension SignInViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView?.passwordTextField.showButton.addTarget(self, action: #selector(didTapShowButton), for: .touchUpInside)
        bind()
    }
}

private extension SignInViewController {
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

}
