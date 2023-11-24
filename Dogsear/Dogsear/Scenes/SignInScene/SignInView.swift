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
    }
}
