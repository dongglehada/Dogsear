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
    
   
    
    // MARK: - 생성자
    init() {
        super.init(frame: .zero)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignInView {
   
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
