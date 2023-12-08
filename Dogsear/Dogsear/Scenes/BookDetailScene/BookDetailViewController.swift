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
        setUpData()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        startIndicatorAnimation()
        viewModel?.fetchPostData(){ [weak self] in
            self?.sceneView.commentTableView.reloadData()
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
        viewModel?.isEdit.bind({ [weak self] state in
            self?.sceneView.commentTableView.isEditing = state ?? false
            self?.sceneView.isEditAble(state: state ?? false)
            self?.setUpNavigation(state: state ?? false)
        })
    }
    
    func setUpData() {
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
    }
    
    func setUp() {
        sceneView.commentTableView.delegate = self
        sceneView.commentTableView.dataSource = self
        sceneView.commentTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        sceneView.recordButton.button.addAction(UIAction { _ in self.didTapRecordButton() }, for: .primaryActionTriggered)
        sceneView.bookStateSegmentControl.addAction(UIAction { _ in self.didChangeBookState() }, for: .valueChanged)
    }
    
    func setUpNavigation(state: Bool) {
        let editButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
            return button
        }()
        editButton.addAction(UIAction(handler: { _ in self.didTapEditButton() }), for: .primaryActionTriggered)
        
        let spacing = UIBarButtonItem(customView: UIView())
        
        let removeButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "trash"), for: .normal)
            return button
        }()
        removeButton.addAction(UIAction(handler: { _ in self.didTapRemoveButton() }), for: .primaryActionTriggered)
        if state {
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: editButton),spacing, UIBarButtonItem(customView: removeButton)]
        } else {
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: editButton)]
        }
    }
    
    func didTapEditButton() {
        viewModel?.isEdit.value?.toggle()
    }
    
    func didTapRemoveButton() {
        let alert = UIAlertController(title: "이 책을 삭제하시겠습니까?", message: "삭제 시 기록들도 함께 삭제됩니다.", preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default) { _ in
            guard let target = self.viewModel?.postData.value else { return }
            self.viewModel?.firebaseManager.deleteBookPost(target: target, completion: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
        }
        let no = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(yes)
        alert.addAction(no)
        self.present(alert, animated: true)
    }
    
    func didTapRecordButton() {
        let vc = CommentAddViewController()
        vc.viewInjection(sceneView: CommentAddView())
        guard let postData = viewModel?.postData.value else { return }
        vc.viewModelInjection(viewModel: CommentAddViewModel(postID: postData.id, comment: nil))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didChangeBookState() {
        switch sceneView.bookStateSegmentControl.selectedSegmentIndex {
        case 0:
            viewModel?.postData.value?.state = .reading
        case 1:
            viewModel?.postData.value?.state = .complete
        case 2:
            viewModel?.postData.value?.state = .expected
        default:
            viewModel?.postData.value?.state = .reading
        }
        self.sceneView.commentTableView.reloadData()
        guard let viewModel = viewModel else { return }
        guard let postdata = viewModel.postData.value else { return }
        startIndicatorAnimation()
        viewModel.firebaseManager.updateBookPost(postBook: postdata) { [weak self] in
            self?.stopIndicatorAnimation()
        }
    }

}

extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let id = viewModel?.postData.value?.id else { return }
            guard let commentId = viewModel?.postData.value?.comments[indexPath.row].id else { return }
            viewModel?.firebaseManager.deleteComment(postID: id, commentID: commentId, completion: { [weak self] in
                self?.viewModel?.postData.value?.comments.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.postData.value?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
        guard let comments = viewModel?.postData.value?.comments else { return UITableViewCell() }
        cell.bind(comment: comments[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let postBookComment = viewModel?.postData.value?.comments[indexPath.row] else { return }
        let vc = CommentAddViewController()
        vc.viewModelInjection(viewModel: CommentAddViewModel(postID: viewModel?.postData.value?.id ?? "", comment: postBookComment))
        vc.viewInjection(sceneView: CommentAddView())
        vc.viewModel?.isEditPost = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
