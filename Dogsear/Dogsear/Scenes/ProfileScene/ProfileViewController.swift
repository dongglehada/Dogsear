//
//  ProfileViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/5/23.
//

import Foundation
import UIKit
import SafariServices

class ProfileViewController: BasicController<ProfileViewModel, ProfileView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.tableView.delegate = self
        sceneView.tableView.dataSource = self
        startIndicatorAnimation()
        viewModel?.firebaseManager.fetchUserData(completion: { [weak self] user in
            self?.sceneView.nickNameLabel.text = user.nickName + "님 안녕하세요!"
            self?.stopIndicatorAnimation()
        })
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.settingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let viewModel = viewModel else { return cell}
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
            let alert = UIAlertController(title: "로그아웃", message: "정말로 로그아웃 하시겠습니까?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "확인", style: .default) { _ in
                self.viewModel?.firebaseManager.logOut(completion: { isLogOut in
                    if isLogOut {
                        let vc = SignInViewController(sceneView: SignInView(), viewModel: SignInViewModel())
                        let rootVC = UINavigationController(rootViewController: vc)
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(viewController: rootVC, animated: false)
                    }
                })
            }
            let no = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(yes)
            alert.addAction(no)
            self.present(alert, animated: true)
        case 2:
            let alert = UIAlertController(title: "회원탈퇴", message: "탈퇴시 모든 데이터가 삭제됩니다.", preferredStyle: .alert)
            let yes = UIAlertAction(title: "확인", style: .default) { _ in
                guard let email = self.viewModel?.firebaseManager.email else { return }
                self.viewModel?.firebaseManager.deleteUser(email: email, completion: {
                    let vc = SignInViewController(sceneView: SignInView(), viewModel: SignInViewModel())
                    let rootVC = UINavigationController(rootViewController: vc)
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(viewController: rootVC, animated: false)
                })
            }
            let no = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(yes)
            alert.addAction(no)
            self.present(alert, animated: true)
        default:
            print("등록되지 않은 Cell")
        }
    }
    
}
