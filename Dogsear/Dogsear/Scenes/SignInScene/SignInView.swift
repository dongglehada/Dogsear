//
//  SignInView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import UIKit
import SnapKit

final class SignInView: UIView {
    
    let logoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .myPointColor
        return view
    }()
    
    let emailTextField = SharedTextField(type: .normal, placeHolder: "이메일")
    let passwordTextField = SharedTextField(type: .password, placeHolder: "비밀번호")
    
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
        self.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constant.screenWidth / 3)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constant.screenHeight * 0.1)
        }
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.defaultPadding)
        }
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Constant.defaultPadding)
            make.left.right.equalToSuperview().inset(Constant.defaultPadding)
        }
    }
}
