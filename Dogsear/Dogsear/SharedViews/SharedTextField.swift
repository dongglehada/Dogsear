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
        case titlePassword
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
    
    lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body2.font
        return label
    }()
    
    private let type: TextFieldType
    
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
            setUpNormal()
        case .password:
            setUpPassword()
        case .title:
            setUpTitle()
        case .titlePassword:
            setUpTitlePassword()
        }
    }
    
    func setUpLayer(type: TextFieldType) {
        if type != .title && type != .titlePassword {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.systemGray4.cgColor
            self.layer.cornerRadius = Constant.defaults.radius
        }
    }
    
    func setUpNormal() {
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpPassword() {
        showButton.addTarget(self, action: #selector(changeShowButtonColor), for: .touchUpInside)
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
    
    func setUpTitle() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        self.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right).offset(Constant.defaults.padding)
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
    
    func setUpTitlePassword() {
        
        textField.isSecureTextEntry = true
        showButton.addTarget(self, action: #selector(changeShowButtonColor), for: .touchUpInside)
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        self.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right).offset(Constant.defaults.padding)
        }
        self.addSubview(trailingView)
        trailingView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.bottom.equalToSuperview()
        }

        trailingView.addSubview(showButton)
        showButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constant.defaults.padding)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(Constant.screenHeight * 0.03)
        }
        trailingView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(Constant.defaults.padding)
            make.right.equalTo(showButton.snp.left)
        }
    }
}

extension SharedTextField {
    // MARK: - Method
    @objc private func changeShowButtonColor() {
        self.textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry {
            UIView.animate(withDuration: 0.1) {
                self.showButton.tintColor = .systemGray4
            }
        } else {
            UIView.animate(withDuration: 0.1) {
                self.showButton.tintColor = .myPointColor
            }
        }
    }
    
    func changeBorderColor(color: UIColor, animated: Bool) {
        
        let action: () -> Void = {
            switch self.type {
            case .normal, .password:
                self.layer.borderColor = color.cgColor
            case .title, .titlePassword:
                self.trailingView.layer.borderColor = color.cgColor
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.4) { action() }
        } else {
            action()
        }
    }
    
    func changeStatelabel(color: UIColor, text: String) {
        stateLabel.text = text
        stateLabel.textColor = color
    }
}
