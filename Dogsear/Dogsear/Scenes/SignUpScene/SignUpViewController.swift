//
//  SignUpViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/2/23.
//

import Foundation
import UIKit
import SafariServices
//BasicController<SignUpViewModel, SignUpView>
class SignUpViewController: UIViewController {
    
    let sceneView: SignUpView
    let viewModel: SignUpViewModel
    
    init(sceneView: SignUpView, viewModel: SignUpViewModel) {
        self.sceneView = sceneView
        self.viewModel = viewModel
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private extension SignUpViewController {
    // MARK: - SetUp

    func setUp() {
        setUpDelegate()
        sceneView.privacyAgreeButton.addTarget(self, action: #selector(didTapPrivacyAgreeButton), for: .touchUpInside)
        sceneView.privacyShowButton.addAction(UIAction(handler: { _ in self.didTapPrivacyShowButton() }), for: .primaryActionTriggered)
        makeBottomButton(title: "회원가입") { [weak self] in
            self?.didTapBottomButton()
        }
    }
    
    func setUpDelegate() {
        sceneView.checkPasswordTextField.textField.delegate = self
        sceneView.emailTextField.textField.delegate = self
        sceneView.nickNameTextField.textField.delegate = self
        sceneView.passwordTextField.textField.delegate = self
    }
    // MARK: - Bind

    func bind() {
        viewModel.emailState.bind({ [weak self] state in
            switch state {
            case .empty:
                self?.sceneView.emailTextField.changeStatelabel(color: .myPointColor, text: "")
            case .alreadyInUse:
                self?.sceneView.emailTextField.changeStatelabel(color: .systemRed, text: "이미 사용중인 이메일 입니다.")
            case .unavailableFormat:
                self?.sceneView.emailTextField.changeStatelabel(color: .systemRed, text: "이메일 주소를 정확히 입력해주세요.")
            case .checking:
                self?.sceneView.emailTextField.changeStatelabel(color: .systemYellow, text: "사용 가능여부 조회중")
            case .available:
                self?.sceneView.emailTextField.changeStatelabel(color: .systemBlue, text: "사용가능한 이메일 입니다.")
            default :
                print("등록되지 않은 상태")
            }
        })
        
        viewModel.nickNameState.bind({ [weak self] state in
            switch state {
            case .empty:
                self?.sceneView.nickNameTextField.changeStatelabel(color: .myPointColor, text: "")
            case .length:
                self?.sceneView.nickNameTextField.changeStatelabel(color: .systemRed, text: "2글자에서 8글자 사이의 닉네임을 입력해주세요.")
            case .available:
                self?.sceneView.nickNameTextField.changeStatelabel(color: .systemBlue, text: "사용가능한 닉네임 입니다.")
            default :
                print("등록되지 않은 상태")
            }
        })
        
        viewModel.passwordState.bind({ [weak self] state in
            switch state {
            case .empty:
                self?.sceneView.passwordTextField.changeStatelabel(color: .myPointColor, text: "")
            case .length:
                self?.sceneView.passwordTextField.changeStatelabel(color: .systemRed, text: "8글자에서 20글자 사이의 비밀번호를 입력해주세요.")
            case .combination:
                self?.sceneView.passwordTextField.changeStatelabel(color: .systemRed, text: "비밀번호는 숫자, 영문, 특수문자를 조합하여야 합니다.")
            case .special:
                self?.sceneView.passwordTextField.changeStatelabel(color: .systemRed, text: "비밀번호는 특수문자를 포함되어야 합니다.")
            case .available:
                self?.sceneView.passwordTextField.changeStatelabel(color: .systemBlue, text: "사용가능한 비밀번호 입니다.")
            default :
                print("등록되지 않은 상태")
            }
        })
        
        viewModel.checkPasswordState.bind({ [weak self] state in
            switch state {
            case .empty:
                self?.sceneView.checkPasswordTextField.changeStatelabel(color: .myPointColor, text: "")
            case .unconformity:
                self?.sceneView.checkPasswordTextField.changeStatelabel(color: .systemRed, text: "비밀번호가 일치하지 않습니다.")
            case .available:
                self?.sceneView.checkPasswordTextField.changeStatelabel(color: .systemBlue, text: "비밀번호가 일치합니다.")
            default :
                print("등록되지 않은 상태")
            }
        })
        
        viewModel.isPrivacyAgree.bind({ [weak self] state in
            guard let state = state else { return }
            if state {
                self?.sceneView.privacyAgreeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            } else {
                self?.sceneView.privacyAgreeButton.setImage(UIImage(systemName: "square"), for: .normal)
            }
        })
    }
}

private extension SignUpViewController {
    // MARK: - Method
    
    @objc func didTapPrivacyAgreeButton() {
        viewModel.isPrivacyAgree.value?.toggle()
    }
    
    func didTapPrivacyShowButton() {
        let privacyPolicyURL = URL(string: "https://plip.kr/pcc/33ee4b14-f641-4ed0-af8b-252891969dc0/privacy/1.html")!
        let safariViewController = SFSafariViewController(url: privacyPolicyURL)
        self.navigationController?.pushViewController(safariViewController, animated: true)
    }
    
    func didTapBottomButton() {
        self.startIndicatorAnimation()
        if viewModel.isValidSignUp() {
            guard let email = self.sceneView.emailTextField.textField.text else { return }
            guard let password = self.sceneView.passwordTextField.textField.text else { return }
            guard let nickName = self.sceneView.nickNameTextField.textField.text else { return }
            
            viewModel.trySignUp(email: email, password: password, nickName: nickName) { isSuccess, errorMessage in
                if isSuccess {
                    AlertMaker.showAlertAction1(vc: self, title: "회원가입 성공", message: "확인 버튼을 누르면 로그인 화면으로 돌아갑니다.") {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    AlertMaker.showAlertAction1(vc: self, title: "회원가입 실패", message: errorMessage)
                }
                self.stopIndicatorAnimation()
            }
        } else {
            AlertMaker.showAlertAction1(vc: self, title: "회원가입 실패", message: "입력하신 내용을 확인해 주세요.")
            self.stopIndicatorAnimation()
        }
    }

}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField {
        case sceneView.emailTextField.textField:
            viewModel.isValidEmail(email: text)
        case sceneView.nickNameTextField.textField:
            viewModel.isValidNickName(nickName: text)
        case sceneView.passwordTextField.textField:
            guard let password = sceneView.checkPasswordTextField.textField.text else { return }
            viewModel.isValidPassword(password: text)
            viewModel.isCheckPassword(password: text, checkPassword: password)
        case sceneView.checkPasswordTextField.textField:
            guard let password = sceneView.passwordTextField.textField.text else { return }
            viewModel.isCheckPassword(password: password, checkPassword: text)
        default:
            print("등록되지 않은 텍스트 필드")
        }
    }
}
