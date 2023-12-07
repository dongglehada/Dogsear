//
//  CommentAddViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation
import UIKit

class CommentAddViewController: BasicController<CommentAddViewModel, CommentAddView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBottomButton(title: "기록하기") { [weak self] in
            guard let self = self else { return }
            guard let viewModel = self.viewModel else { return }
            guard let bookText = self.sceneView.bookTextView.text else { return }
            guard let myText = self.sceneView.myTextView.text else { return }
            if viewModel.isVaildCommet(bookText: bookText, myText: myText) {
                viewModel.makeCommentPost(bookText: bookText, myText: myText) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                self.makeAlert(title: "실패", message: "입력하신 내용을 확인해 주세요.")
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private extension CommentAddViewController {
    func setUp() {
//        sceneView.bookTextView.delegate = self
//        sceneView.myTextView.delegate = self
    }
}
