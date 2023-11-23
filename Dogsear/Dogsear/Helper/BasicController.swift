//
//  BasicController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import UIKit

class BasicController<ViewModel,SceneView>: UIViewController {
    // MARK: - Property
    
    private var viewModel: ViewModel!
    private var sceneView: SceneView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        setUpColor()
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

}
