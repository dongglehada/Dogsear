//
//  BottomLineTextField.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import UIKit
import SnapKit

class BottomLineTextField: UIView {
    
    let textField: UITextField = {
        let view = UITextField()
        view.font = Typography.body3.font
        return view
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .myPointColor
        return view
    }()
    
    init(placeHolder: String, text: String) {
        super.init(frame: .zero)
        textField.placeholder = placeHolder
        textField.text = text
        setUp()
    }
    convenience init(placeHolder: String, text: String, font: UIFont) {
        self.init(placeHolder: placeHolder, text: text)
        textField.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BottomLineTextField {
    
    func setUp() {
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(Constant.defaults.padding / 2)
            make.left.equalTo(textField.snp.left)
            make.right.equalTo(textField.snp.right)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
}
