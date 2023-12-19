//
//  ProfileViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/5/23.
//

import Foundation
import UIKit
import SafariServices

class ProfileViewController: BasicController {
    // MARK: - Property
    private let viewModel: ProfileViewModel
    
    // MARK: - Components
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title1.font
        return label
    }()
    
    private let nickNameDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .myPointColor
        return view
    }()
    
    private let versionInfo: UILabel = {
        let label = UILabel()
        label.font = Typography.body3.font
        label.text = "App Info"
        return label
    }()
    
    private let appIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "AppIcon")
        view.layer.cornerRadius = Constant.defaults.radius * 2
        view.layer.masksToBounds = true
        return view
    }()
    
    private let appInfoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title3.font
        label.text = "도그지어"
        return label
    }()
    
    private let appVersionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title3.font
        label.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return label
    }()
    
    private let appInfoDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .myPointColor
        return view
    }()
    
    private let developerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body3.font
        label.text = "Developer"
        return label
    }()
    
    private let developerLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body3.font
        label.text = "서준영: ghddns34@gmail.com"
        return label
    }()
    
    private let developerDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .myPointColor
        return view
    }()
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        return view
    }()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setUpConstraints()
        setUpNickName()
    }
}

private extension ProfileViewController {
    // MARK: - SetUp
    
    func setUpNickName() {
        IndicatorMaker.showLoading()
        viewModel.firebaseManager.fetchUserData(completion: { [weak self] user in
            self?.nickNameLabel.text = user.nickName + "님 안녕하세요!"
            IndicatorMaker.hideLoading()
        })
    }
    
    func setUpConstraints() {
        view.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
        }
        view.addSubview(nickNameDivider)
        nickNameDivider.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(1)
        }
        view.addSubview(versionInfo)
        versionInfo.snp.makeConstraints { make in
            make.top.equalTo(nickNameDivider.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(appIconImageView)
        appIconImageView.snp.makeConstraints { make in
            make.top.equalTo(versionInfo.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
            make.width.height.equalTo(Constant.screenWidth / 5)
        }
        view.addSubview(appInfoStackView)
        appInfoStackView.addArrangedSubview(appNameLabel)
        appInfoStackView.addArrangedSubview(appVersionLabel)
        appInfoStackView.snp.makeConstraints { make in
            make.centerY.equalTo(appIconImageView.snp.centerY)
            make.left.equalTo(appIconImageView.snp.right).offset(Constant.defaults.padding)
        }
        view.addSubview(appInfoDivider)
        appInfoDivider.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(1)
        }
        view.addSubview(developerTitleLabel)
        developerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(appInfoDivider.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(developerLabel)
        developerLabel.snp.makeConstraints { make in
            make.top.equalTo(developerTitleLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(developerDivider)
        developerDivider.snp.makeConstraints { make in
            make.top.equalTo(developerLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(1)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(developerDivider.snp.bottom).offset(Constant.defaults.padding)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
            make.left.right.equalToSuperview()
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.settingItems[indexPath.row].title
        cell.imageView?.image = viewModel.settingItems[indexPath.row].iamge
        cell.imageView?.tintColor = .myPointColor
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let privacyPolicyURL = URL(string: "https://plip.kr/pcc/33ee4b14-f641-4ed0-af8b-252891969dc0/privacy/1.html")!
            let safariViewController = SFSafariViewController(url: privacyPolicyURL)
            self.navigationController?.pushViewController(safariViewController, animated: true)
        case 1:
            AlertMaker.showAlertAction2(vc: self,title: "로그아웃", message: "정말로 로그아웃 하시겠습니까?", cancelTitle: "취소", completeTitle: "확인", nil, {
                self.viewModel.firebaseManager.logOut(completion: { isLogOut in
                    if isLogOut {
                        let vc = SignInViewController(viewModel: SignInViewModel())
                        let rootVC = UINavigationController(rootViewController: vc)
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(viewController: rootVC, animated: false)
                    }
                })
            })
        case 2:
            AlertMaker.showAlertAction2(vc: self,title: "회원탈퇴", message: "탈퇴시 모든 데이터가 삭제됩니다.", cancelTitle: "취소", completeTitle: "확인", nil, {
                guard let email = self.viewModel.firebaseManager.email else { return }
                self.viewModel.firebaseManager.deleteUser(email: email, completion: {
                    let vc = SignInViewController(viewModel: SignInViewModel())
                    let rootVC = UINavigationController(rootViewController: vc)
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(viewController: rootVC, animated: false)
                })
            })
        default:
            print("등록되지 않은 Cell")
        }
    }
}
