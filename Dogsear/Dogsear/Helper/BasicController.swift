//
//  BasicController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import UIKit
import SnapKit

class BasicController<ViewModel,SceneView: UIView>: UIViewController {
    // MARK: - Property
    
    var viewModel: ViewModel?
    var sceneView: SceneView!
    
    lazy var customButton = SharedButton(title: "직접 입력하기")
    
    lazy var activityIndicator = ActivityIndicator()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        setUpColor()
        setUpView()
    }
}

private extension BasicController {
    // MARK: - SetUp
    private func setUpColor() {
        view.backgroundColor = .systemBackground
    }

    private func setUpView() {
        self.view.addSubview(sceneView)
        sceneView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        sceneView.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
}

extension BasicController {
    // MARK: - Injection
    func viewModelInjection(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func viewInjection(sceneView: SceneView) {
        self.sceneView = sceneView
    }
}
extension BasicController {
    // MARK: - Make Bottom Button

    func makeBottomButton(title:String, action: @escaping () -> Void) {
        sceneView.addSubview(customButton)
        customButton.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        customButton.button.setTitle(title, for: .normal)
        customButton.button.addAction(UIAction(handler: { state in
            action()
        }), for: .primaryActionTriggered)// touch up inside 랑 비슷
    }
}
extension BasicController {
    // MARK: - Make Alert
    func makeAlert(title: String, message: String?, action: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default) { _ in
            action()
        }
        alert.addAction(yes)
        self.present(alert, animated: true)
    }
    func makeAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default) { _ in }
        alert.addAction(yes)
        self.present(alert, animated: true)
    }
}

extension BasicController {
    // MARK: - Indicator Animation
    
    func startIndicatorAnimation() {
        self.activityIndicator.startAnimating()
    }

    func stopIndicatorAnimation() {
        self.activityIndicator.stopAnimating()
    }
}
