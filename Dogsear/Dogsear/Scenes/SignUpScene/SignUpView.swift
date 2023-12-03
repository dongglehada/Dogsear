//
//  SignUpView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/2/23.
//

import Foundation
import UIKit

class SignUpView: UIView {
    
    let signUpTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title1.font
        label.text = "회원가입"
        return label
    }()
    let emailTextField = SharedTextField(type: .title, placeHolder: "이메일을 입력해주세요.", title: "이메일")
    let nickNameTextField = SharedTextField(type: .title, placeHolder: "닉네임을 입력해주세요.", title: "닉네임")
    let passwordTextField = SharedTextField(type: .titlePassword, placeHolder: "비밀번호를 입력해주세요.", title: "비밀번호")
    let checkPasswordTextField = SharedTextField(type: .titlePassword, placeHolder: "동일한 비밀번호를 입력해주세요.", title: "비밀번호 확인")
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignUpView {
    func setUp() {
        setUpSignUpLabel()
        setUpEmailTextField()
        setUpNickNameTextField()
        setUpPasswordTextField()
        setUpCheckPasswordTextField()
    }
    
    func setUpSignUpLabel() {
        self.addSubview(signUpTitleLabel)
        signUpTitleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpEmailTextField() {
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(signUpTitleLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpNickNameTextField() {
        self.addSubview(nickNameTextField)
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpPasswordTextField() {
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpCheckPasswordTextField() {
        self.addSubview(checkPasswordTextField)
        checkPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
}
