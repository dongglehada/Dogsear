//
//  BookDetailViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation
import UIKit

class BookDetailViewController: BasicController {
    // MARK: - Property
    private let viewModel: BookDetailViewModel
    
    // MARK: - Components
    private let bookStateSegmentControl = BookStateSegmentControl()
    private let bookImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        return view
    }()
    
    private let titleTextField = BottomLineTextField(placeHolder: "제목을 입력해 주세요.", text: "test", font: Typography.title3.font)
    private let authorTextField = BottomLineTextField(placeHolder: "저자를 입력해 주세요.", text: "test")
    private let publisherTextField = BottomLineTextField(placeHolder: "출판사를 입력해 주세요.", text: "test")
    private let recordButton = SharedButton(title: "기록하기")
    private let commentTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookDetailViewController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        setUp()
        setUpData()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        IndicatorMaker.showLoading()
        viewModel.fetchPostData(){ [weak self] in
            self?.commentTableView.reloadData()
            self?.commentTableView.beginUpdates()
            self?.commentTableView.endUpdates()
            IndicatorMaker.hideLoading()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

private extension BookDetailViewController {
    // MARK: - Method
    func setUp() {
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        recordButton.button.addAction(UIAction { [weak self] _ in self?.didTapRecordButton() }, for: .primaryActionTriggered)
        bookStateSegmentControl.addAction(UIAction { [weak self] _ in self?.didChangeBookState() }, for: .valueChanged)
        titleTextField.textField.isEnabled = false
        authorTextField.textField.isEnabled = false
        publisherTextField.textField.isEnabled = false
    }
    
    func setUpData() {
        bookImageView.kf.setImage(with: viewModel.postData.value?.imageUrl)
        titleTextField.textField.text = viewModel.postData.value?.title
        authorTextField.textField.text = "저자: " + (viewModel.postData.value?.author ?? "")
        publisherTextField.textField.text = "출판사: " + (viewModel.postData.value?.publisher ?? "")
        guard let state = viewModel.postData.value?.state else { return }
        var tempIndex = 0
        switch state {
        case .reading:
            tempIndex = 0
        case .complete:
            tempIndex = 1
        case .expected:
            tempIndex = 2
        }
        bookStateSegmentControl.selectedSegmentIndex = tempIndex
    }
    
    func setUpNavigation(state: Bool) {
        let editButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
            return button
        }()
        editButton.addAction(UIAction(handler: { [weak self] _ in self?.didTapEditButton() }), for: .primaryActionTriggered)
        
        let spacing = UIBarButtonItem(customView: UIView())
        
        let removeButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "trash"), for: .normal)
            return button
        }()
        removeButton.addAction(UIAction(handler: { [weak self] _ in self?.didTapRemoveButton() }), for: .primaryActionTriggered)
        if state {
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: editButton),spacing, UIBarButtonItem(customView: removeButton)]
        } else {
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: editButton)]
        }
    }
    
    func setUpConstraints() {

        view.addSubview(bookStateSegmentControl)
        bookStateSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(bookImageView)
        bookImageView.snp.makeConstraints { make in
            make.height.equalTo(Constant.bookSize.height)
            make.width.equalTo(Constant.bookSize.width)
            make.top.equalTo(bookStateSegmentControl.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.top)
            make.left.equalTo(bookImageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(authorTextField)
        authorTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(Constant.defaults.padding / 2)
            make.left.equalTo(bookImageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(publisherTextField)
        publisherTextField.snp.makeConstraints { make in
            make.top.equalTo(authorTextField.snp.bottom).offset(Constant.defaults.padding / 2)
            make.left.equalTo(bookImageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(recordButton)
        recordButton.snp.makeConstraints { make in
            make.top.equalTo(publisherTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalTo(bookImageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
            make.bottom.equalTo(bookImageView.snp.bottom)
        }
        view.addSubview(commentTableView)
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(recordButton.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

private extension BookDetailViewController {
    // MARK: - Bind
    func bind() {
        viewModel.isEdit.bind({ [weak self] state in
            self?.commentTableView.isEditing = state ?? false
            self?.isEditAble(state: state ?? false)
            self?.setUpNavigation(state: state ?? false)
        })
    }
}

private extension BookDetailViewController {
    // MARK: - Method
    
    func didTapEditButton() {
        viewModel.isEdit.value?.toggle()
    }
    
    func didTapRemoveButton() {
        AlertMaker.showAlertAction2(vc:self, title: "이 책을 삭제하시겠습니까?", message: "삭제 시 기록들도 함께 삭제됩니다.", nil) {
            guard let target = self.viewModel.postData.value else { return }
            self.viewModel.firebaseManager.deleteBookPost(target: target, completion: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    func didTapRecordButton() {
        guard let postData = viewModel.postData.value else { return }
        let vcViewModel = CommentAddViewModel(postID: postData.id, comment: nil)
        let vc = CommentAddViewController(viewModel: vcViewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didChangeBookState() {
        switch bookStateSegmentControl.selectedSegmentIndex {
        case 0:
            viewModel.postData.value?.state = .reading
        case 1:
            viewModel.postData.value?.state = .complete
        case 2:
            viewModel.postData.value?.state = .expected
        default:
            viewModel.postData.value?.state = .reading
        }
        self.commentTableView.reloadData()
        guard let postdata = viewModel.postData.value else { return }
        IndicatorMaker.showLoading()
        viewModel.firebaseManager.updateBookPost(postBook: postdata) {
            IndicatorMaker.hideLoading()
        }
    }
    
    func isEditAble(state: Bool) {
        titleTextField.textField.isEnabled = state
        authorTextField.textField.isEnabled = state
        publisherTextField.textField.isEnabled = state
        if state {
            titleTextField.changeBottomLineColor(color: .systemGray4)
            authorTextField.changeBottomLineColor(color: .systemGray4)
            publisherTextField.changeBottomLineColor(color: .systemGray4)
        } else {
            titleTextField.changeBottomLineColor(color: .myPointColor)
            authorTextField.changeBottomLineColor(color: .myPointColor)
            publisherTextField.changeBottomLineColor(color: .myPointColor)
        }

    }
}

extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let id = viewModel.postData.value?.id else { return }
            guard let commentId = viewModel.postData.value?.comments[indexPath.row].id else { return }
            viewModel.firebaseManager.deleteComment(postID: id, commentID: commentId, completion: { [weak self] in
                self?.viewModel.postData.value?.comments.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postData.value?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
        guard let comments = viewModel.postData.value?.comments else { return UITableViewCell() }
        let state = viewModel.getCommentState(comment: comments[indexPath.row])
        cell.bind(comment: comments[indexPath.row], state: state)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let postBookComment = viewModel.postData.value?.comments[indexPath.row] else { return }
        let viewModel = CommentAddViewModel(postID: viewModel.postData.value?.id ?? "", comment: postBookComment)
        viewModel.isEditPost = true
        let vc = CommentAddViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
