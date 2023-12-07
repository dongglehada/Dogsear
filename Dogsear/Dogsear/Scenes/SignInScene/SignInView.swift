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
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let emailTextField = SharedTextField(type: .normal, placeHolder: "이메일")
    let passwordTextField = SharedTextField(type: .password, placeHolder: "패스워드")
    private let missMatchLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body3.font
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.alpha = 1
        return label
    }()
    let autoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("자동 로그인", for: .normal)
        button.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: Constant.defaults.padding)
        button.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -Constant.defaults.padding / 2)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Typography.body3.font
        button.tintColor = .myPointColor
        return button
    }()
    
    let signInButton = SharedButton(title: "로그인")
    
    private let buttonsStackView: UIStackView = {
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
        setUpMissMatchLabel()
        setUpAutoLoginButton()
        setUpSignInButton()
        setUpButtonStackView()
    }
    
    func setUpLogoImageView() {
        self.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.screenHeight * 0.1)
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
    
    func setUpMissMatchLabel() {
        self.addSubview(missMatchLabel)
        missMatchLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom)
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

extension SignInView {
    // MARK: - Method
    func missMatchLabelShow(isShow: Bool, content: String?) {
        if isShow {
            missMatchLabel.text = content
            missMatchLabel.alpha = 1
            missMatchLabel.shake()
        } else {
            missMatchLabel.alpha = 0
        }
    }
}
