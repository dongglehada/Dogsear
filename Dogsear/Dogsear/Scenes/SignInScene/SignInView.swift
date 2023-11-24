//
//  SignInView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import UIKit
import SnapKit

final class SignInView: UIView {
    // MARK: - Property
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.font = Typography.title1.font
        return label
    }()
    
    let emailTextField = SharedTextField(type: .normal, placeHolder: "이메일")
    let passwordTextField = SharedTextField(type: .password, placeHolder: "비밀번호")
    let signInButton = SharedButton(title: "로그인")
    
    // MARK: - 생성자
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignInView {
    func setUp() {
        self.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constant.defaults.padding)
            make.top.equalToSuperview().offset(Constant.screenHeight * 0.2)
        }
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
}
