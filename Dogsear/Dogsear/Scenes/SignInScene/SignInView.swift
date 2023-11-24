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
    
    let logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let emailTextField = SharedTextField(type: .normal, placeHolder: "이메일")
    let passwordTextField = SharedTextField(type: .password, placeHolder: "패스워드")
    let autoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 상태 유지", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Typography.body3.font
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        button.tintColor = .myPointColor
        return button
    }()
    
    let signInButton = SharedButton(title: "로그인")
    
    let buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .trailing
        view.spacing = Constant.defaults.padding
        view.distribution = .fill
        return view
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = Typography.body3.font
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    let passwordFindButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = Typography.body3.font
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    
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
        setUpLogoImageView()
        setUpEmailTextField()
        setUpPasswordTextField()
        setUpAutoLoginButton()
        setUpSignInButton()
        setUpButtonStackView()
    }
    
    func setUpLogoImageView() {
        self.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.screenHeight * 0.2)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constant.screenWidth / 2)
            make.height.equalTo(Constant.screenHeight * 0.05)
        }
    }
    
    func setUpEmailTextField() {
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(Constant.defaults.padding * 2)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpPasswordTextField() {
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpAutoLoginButton() {
        self.addSubview(autoLoginButton)
        autoLoginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constant.defaults.padding * 2)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpButtonStackView() {
        self.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(autoLoginButton.snp.centerY)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        buttonsStackView.addArrangedSubview(passwordFindButton)
        buttonsStackView.addArrangedSubview(signUpButton)
    }
    
    func setUpSignInButton() {
        self.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(autoLoginButton.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
}
