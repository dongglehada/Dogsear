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
        guard let state = viewModel?.isEditPost else { return }
        
        if state {
            sceneView.bookTextView.text = viewModel?.comment?.bookComment
            sceneView.myTextView.text = viewModel?.comment?.myComment
            makeBottomButton(title: "수정하기") { [weak self] in
                guard let self = self else { return }
                didTapBottomButton(state: state)
            }
        } else {
            makeBottomButton(title: "기록하기") { [weak self] in
                guard let self = self else { return }
                didTapBottomButton(state: state)
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
    func didTapBottomButton(state: Bool) {
        guard let viewModel = self.viewModel else { return }
        guard let bookText = self.sceneView.bookTextView.text else { return }
        guard let myText = self.sceneView.myTextView.text else { return }
        if viewModel.isVaildCommet(bookText: bookText, myText: myText) {
            if state {
                viewModel.comment?.bookComment = bookText
                viewModel.comment?.myComment = myText
                guard let comment = viewModel.comment else { return }
                
                viewModel.firebaseManager.updateComment(postID: viewModel.postID, updateComment: comment) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                viewModel.makeCommentPost(bookText: bookText, myText: myText) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            self.makeAlert(title: "실패", message: "입력하신 내용을 확인해 주세요.")
        }
    }
    
}
