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
        case title
    }
    
    var textField: UITextField = {
        let view = UITextField()
        view.font = Typography.body1.font
        return view
    }()
    
    lazy var showButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .systemGray4
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body2.font
        label.textColor = .black
        return label
    }()
    
    lazy var trailingView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.cornerRadius = Constant.defaults.radius
        return view
    }()
    
    let type: TextFieldType
    
    init(type: TextFieldType, placeHolder: String) {
        self.type = type
        super.init(frame: .zero)
        textField.placeholder = placeHolder
        setUp(type: type)
    }
    
    convenience init(type: TextFieldType, placeHolder: String, title: String) {
        self.init(type: type, placeHolder: placeHolder)
        self.titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SharedTextField {
    func setUp(type: TextFieldType) {
        setUpLayer(type: type)
        switch type {
        case .normal:
            normalSetUp()
        case .password:
            passwordSetUp()
        case .title:
            titleSetUp()
        }
    }
    
    func setUpLayer(type: TextFieldType) {
        if type != .title {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.systemGray4.cgColor
            self.layer.cornerRadius = Constant.defaults.radius
        }
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
    
    func titleSetUp() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        self.addSubview(trailingView)
        trailingView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.bottom.equalToSuperview()
        }
        trailingView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constant.defaults.padding)
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

    func changeBorderColor(color: UIColor) {
        UIView.animate(withDuration: 0.1) {
            self.layer.borderColor = color.cgColor
        }
    }
}
