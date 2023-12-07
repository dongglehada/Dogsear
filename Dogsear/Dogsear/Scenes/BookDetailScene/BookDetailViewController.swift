//
//  BookDetailViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation
import UIKit

class BookDetailViewController: BasicController<BookDetailViewModel, BookDetailView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        startIndicatorAnimation()
        viewModel?.fetchPostData(){ [weak self] in
            self?.stopIndicatorAnimation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

private extension BookDetailViewController {
    // MARK: - Method
    
    func bind() {
        viewModel?.postData.bind({ [weak self] _ in
            self?.sceneView.commentTableView.reloadData()
        })
    }
    
    func setUp() {
        sceneView.commentTableView.delegate = self
        sceneView.commentTableView.dataSource = self
        sceneView.commentTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        sceneView.bookImageView.kf.setImage(with: viewModel?.postData.value?.imageUrl)
        sceneView.titleTextField.textField.text = viewModel?.postData.value?.title
        sceneView.authorTextField.textField.text = "저자: " + (viewModel?.postData.value?.author ?? "")
        sceneView.publisherTextField.textField.text = "출판사: " + (viewModel?.postData.value?.publisher ?? "")
        guard let state = viewModel?.postData.value?.state else { return }
        var tempIndex = 0
        switch state {
        case .reading:
            tempIndex = 0
        case .complete:
            tempIndex = 1
        case .expected:
            tempIndex = 2
        }
        sceneView.bookStateSegmentControl.selectedSegmentIndex = tempIndex
        let action = UIAction { _ in
            let vc = CommentAddViewController()
            vc.viewInjection(sceneView: CommentAddView())
            vc.viewModelInjection(viewModel: CommentAddViewModel(postID: self.viewModel?.postData.value?.id))
            self.navigationController?.pushViewController(vc, animated: true)
        }
        sceneView.recordButton.button.addAction(action, for: .primaryActionTriggered)
    }

}

extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.postData.value?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
        guard let comments = viewModel?.postData.value?.comments else { return cell}
        cell.bind(comment: comments[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
