//
//  BasicController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import UIKit
import SnapKit

class BasicController<ViewModel,SceneView>: UIViewController {
    // MARK: - Property
    
    var viewModel: ViewModel?
    var sceneView: SceneView?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        setUpColor()
        setUpView()
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
        self.view.addSubview(sceneView as! UIView)
        (sceneView as! UIView).snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
