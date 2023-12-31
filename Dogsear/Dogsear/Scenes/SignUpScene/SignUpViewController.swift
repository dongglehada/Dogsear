//
//  SignUpViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/2/23.
//

import Foundation
import UIKit
import SafariServices

class SignUpViewController: BasicController {
    // MARK: - Property
    private let viewModel: SignUpViewModel
    
    // MARK: - Components

    private let signUpTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title1.font
        label.text = "회원가입"
        return label
    }()
    private let emailTextField = SharedTextField(type: .title, placeHolder: "이메일을 입력해주세요.", title: "이메일")
    private let nickNameTextField = SharedTextField(type: .title, placeHolder: "닉네임을 입력해주세요.", title: "닉네임")
    private let passwordTextField = SharedTextField(type: .titlePassword, placeHolder: "비밀번호를 입력해주세요.", title: "비밀번호")
    private let checkPasswordTextField = SharedTextField(type: .titlePassword, placeHolder: "동일한 비밀번호를 입력해주세요.", title: "비밀번호 확인")
    private let privacyAgreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("개인정보 처리방침에 동의합니다.", for: .normal)
        button.titleLabel?.font = Typography.body2.font
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.tintColor = .myPointColor
        return button
    }()
    
    private let privacyShowButton: UIButton = {
        let button = UIButton()
        button.setTitle("[보기]", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Typography.body2.font
        return button
    }()
    
    private let signUpButton = SharedButton(title: "회원가입")
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SignUpViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
    }
}

private extension SignUpViewController {
    // MARK: - SetUp

    func setUp() {
        setUpConstraints()
        setUpDelegate()
        setUpAddAction()
    }
    
    func setUpConstraints() {
        view.addSubview(signUpTitleLabel)
        signUpTitleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(signUpTitleLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        view.addSubview(nickNameTextField)
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        view.addSubview(checkPasswordTextField)
        checkPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        view.addSubview(privacyAgreeButton)
        privacyAgreeButton.snp.makeConstraints { make in
            make.top.equalTo(checkPasswordTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        view.addSubview(privacyShowButton)
        privacyShowButton.snp.makeConstraints { make in
            make.centerY.equalTo(privacyAgreeButton.snp.centerY)
            make.left.equalTo(privacyAgreeButton.snp.right).offset(Constant.defaults.padding)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
        }
    }
    
    func setUpDelegate() {
        checkPasswordTextField.textField.delegate = self
        emailTextField.textField.delegate = self
        nickNameTextField.textField.delegate = self
        passwordTextField.textField.delegate = self
    }
    
    func setUpAddAction() {
        privacyAgreeButton.addTarget(self, action: #selector(didTapPrivacyAgreeButton), for: .primaryActionTriggered)
        privacyShowButton.addTarget(self, action: #selector(didTapPrivacyShowButton), for: .primaryActionTriggered)
        signUpButton.button.addTarget(self, action: #selector(didTapBottomButton), for: .primaryActionTriggered)
    }
}

private extension SignUpViewController {
    // MARK: - bind
    func bind() {
        viewModel.emailState.bind({ [weak self] state in
            switch state {
            case .empty:
                self?.emailTextField.changeStatelabel(color: .myPointColor, text: "")
            case .alreadyInUse:
                self?.emailTextField.changeStatelabel(color: .systemRed, text: "이미 사용중인 이메일 입니다.")
            case .unavailableFormat:
                self?.emailTextField.changeStatelabel(color: .systemRed, text: "이메일 주소를 정확히 입력해주세요.")
            case .checking:
                self?.emailTextField.changeStatelabel(color: .systemYellow, text: "사용 가능여부 조회중")
            case .available:
                self?.emailTextField.changeStatelabel(color: .systemBlue, text: "사용가능한 이메일 입니다.")
            default :
                print("등록되지 않은 상태")
            }
        })
        
        viewModel.nickNameState.bind({ [weak self] state in
            switch state {
            case .empty:
                self?.nickNameTextField.changeStatelabel(color: .myPointColor, text: "")
            case .length:
                self?.nickNameTextField.changeStatelabel(color: .systemRed, text: "2글자에서 8글자 사이의 닉네임을 입력해주세요.")
            case .available:
                self?.nickNameTextField.changeStatelabel(color: .systemBlue, text: "사용가능한 닉네임 입니다.")
            default :
                print("등록되지 않은 상태")
            }
        })
        
        viewModel.passwordState.bind({ [weak self] state in
            switch state {
            case .empty:
                self?.passwordTextField.changeStatelabel(color: .myPointColor, text: "")
            case .length:
                self?.passwordTextField.changeStatelabel(color: .systemRed, text: "8글자에서 20글자 사이의 비밀번호를 입력해주세요.")
            case .combination:
                self?.passwordTextField.changeStatelabel(color: .systemRed, text: "비밀번호는 숫자, 영문, 특수문자를 조합하여야 합니다.")
            case .special:
                self?.passwordTextField.changeStatelabel(color: .systemRed, text: "비밀번호는 특수문자를 포함되어야 합니다.")
            case .available:
                self?.passwordTextField.changeStatelabel(color: .systemBlue, text: "사용가능한 비밀번호 입니다.")
            default :
                print("등록되지 않은 상태")
            }
        })
        
        viewModel.checkPasswordState.bind({ [weak self] state in
            switch state {
            case .empty:
                self?.checkPasswordTextField.changeStatelabel(color: .myPointColor, text: "")
            case .unconformity:
                self?.checkPasswordTextField.changeStatelabel(color: .systemRed, text: "비밀번호가 일치하지 않습니다.")
            case .available:
                self?.checkPasswordTextField.changeStatelabel(color: .systemBlue, text: "비밀번호가 일치합니다.")
            default :
                print("등록되지 않은 상태")
            }
        })
        
        viewModel.isPrivacyAgree.bind({ [weak self] state in
            guard let state = state else { return }
            if state {
                self?.privacyAgreeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            } else {
                self?.privacyAgreeButton.setImage(UIImage(systemName: "square"), for: .normal)
            }
        })
    }
}

private extension SignUpViewController {
    // MARK: - Method
    @objc
    func didTapPrivacyAgreeButton() {
        viewModel.isPrivacyAgree.value?.toggle()
    }
    @objc
    func didTapPrivacyShowButton() {
        let privacyPolicyURL = URL(string: "https://plip.kr/pcc/33ee4b14-f641-4ed0-af8b-252891969dc0/privacy/1.html")!
        let safariViewController = SFSafariViewController(url: privacyPolicyURL)
        self.navigationController?.pushViewController(safariViewController, animated: true)
    }
    @objc
    func didTapBottomButton() {
        IndicatorMaker.showLoading()
        if viewModel.isValidSignUp() {
            guard let email = self.emailTextField.textField.text else { return }
            guard let password = self.passwordTextField.textField.text else { return }
            guard let nickName = self.nickNameTextField.textField.text else { return }
            
            viewModel.trySignUp(email: email, password: password, nickName: nickName) { isSuccess, errorMessage in
                if isSuccess {
                    AlertMaker.showAlertAction1(vc: self, title: "회원가입 성공", message: "확인 버튼을 누르면 로그인 화면으로 돌아갑니다.") {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    AlertMaker.showAlertAction1(vc: self, title: "회원가입 실패", message: errorMessage)
                }
                IndicatorMaker.hideLoading()
            }
        } else {
            AlertMaker.showAlertAction1(vc: self, title: "회원가입 실패", message: "입력하신 내용을 확인해 주세요.")
            IndicatorMaker.hideLoading()
        }
    }

}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField {
        case emailTextField.textField:
            viewModel.isValidEmail(email: text)
        case nickNameTextField.textField:
            viewModel.isValidNickName(nickName: text)
        case passwordTextField.textField:
            guard let password = checkPasswordTextField.textField.text else { return }
            viewModel.isValidPassword(password: text)
            viewModel.isCheckPassword(password: text, checkPassword: password)
        case checkPasswordTextField.textField:
            guard let password = passwordTextField.textField.text else { return }
            viewModel.isCheckPassword(password: password, checkPassword: text)
        default:
            print("등록되지 않은 텍스트 필드")
        }
    }
}
