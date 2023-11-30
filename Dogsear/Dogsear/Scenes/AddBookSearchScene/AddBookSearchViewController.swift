//
//  AddBookSearchViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/29/23.
//

import UIKit

class AddBookSearchViewController: BasicController<AddBookSearchViewModel,AddBookSearchView> {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleViewSetUpLogoImage()
        makeBottomButton(title: "직접 입력하기")
    }

    override func didTapBottomButton() {
        let rootVC = AddBookViewController()
        rootVC.viewInjection(sceneView: AddBookView())
        rootVC.viewModelInjection(viewModel: AddBookViewModel())
        navigationController?.pushViewController(rootVC, animated: true)
    }
}



