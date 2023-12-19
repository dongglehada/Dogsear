//
//  BasicController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import UIKit
import SnapKit

class BasicController: UIViewController {
    
    deinit {
        Log(.deinit).logger(self)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        setUpColor()
    }
}

private extension BasicController {
    // MARK: - SetUp
    private func setUpColor() {
        view.backgroundColor = .systemBackground
    }
}
