//
//  AddBookViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import UIKit

class AddBookViewController: BasicController<AddBookViewModel,AddBookView> {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBottomButton(title: "추가 하기")
        navigationItem.titleViewSetUpLogoImage()
    }
}
