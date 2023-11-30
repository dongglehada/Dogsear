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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        setUpColor()
        setUpView()
    }
    
    func didTapBottomButton() {
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
    
    // MARK: - ColorSetUp
    private func setUpColor() {
        view.backgroundColor = .systemBackground
    }

    private func setUpView() {
        self.view.addSubview(sceneView)
        sceneView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func makeBottomButton(title:String) {
        sceneView.addSubview(customButton)
        customButton.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        customButton.button.setTitle(title, for: .normal)
        customButton.button.addAction(UIAction(handler: { state in
            self.didTapBottomButton()
        }), for: .touchUpInside)
    }
    
}

