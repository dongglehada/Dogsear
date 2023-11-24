//
//  DefaultTextField.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/24/23.
//

import UIKit

class SharedTextField: UIView {

    enum TextFieldType {
        case normal
        case password
    }
    
    var textField: UITextField = {
        let view = UITextField()
        view.font = Typography.body1.font
        return view
    }()
    
    let showButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .systemGray4
        return button
    }()
    
    init(type: TextFieldType, placeHolder: String) {
        super.init(frame: .zero)
        textField.placeholder = placeHolder
        setUp(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SharedTextField {
    func setUp(type: TextFieldType) {
        setUpLayer()
        switch type {
        case .normal:
            normalSetUp()
        case .password:
            passwordSetUp()
        }
    }
    
    func setUpLayer() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.cornerRadius = Constant.defaults.radius
    }
    
    func normalSetUp() {
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func passwordSetUp() {
        textField.isSecureTextEntry = true
        self.addSubview(showButton)
        showButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constant.defaults.padding)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(Constant.screenHeight * 0.03)
        }
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(Constant.defaults.padding)
            make.right.equalTo(showButton.snp.left)
        }
    }
}

extension SharedTextField {
    // MARK: - Method
    func changeShowButtonColor(state: Bool) {
        if state {
            UIView.animate(withDuration: 0.1) {
                self.textField.isSecureTextEntry = false
                self.showButton.tintColor = .myPointColor
            }
        } else {
            UIView.animate(withDuration: 0.1) {
                self.textField.isSecureTextEntry = true
                self.showButton.tintColor = .systemGray4
            }
        }
    }

}
