//
//  CommentAddViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation
import UIKit

class CommentAddViewController: BasicController {

    // MARK: - Property
    private var viewModel: CommentAddViewModelProtocol
    
    
    // MARK: - Components
    private let bookTextLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body1.font
        label.text = "책의 문장"
        return label
    }()
    
    private let bookTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = Constant.defaults.radius
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.font = Typography.body2.font
        return view
    }()
    
    private let myTextLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body1.font
        label.text = "나의 생각"
        return label
    }()
    
    private let myTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = Constant.defaults.radius
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.font = Typography.body2.font
        return view
    }()
    
    private let bottomButton = SharedButton(title: "some")
    

    init(viewModel: CommentAddViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentAddViewController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

private extension CommentAddViewController {
    // MARK: - SetUp
    
    func setUp() {
        setUpConstraints()
        setUpBottomButton()
    }
    func setUpBottomButton() {
        let state = viewModel.isEditPost
        
        if state {
            bookTextView.text = viewModel.comment?.bookComment
            myTextView.text = viewModel.comment?.myComment
            bottomButton.button.setTitle("수정하기", for: .normal)
        } else {
            bottomButton.button.setTitle("기록하기", for: .normal)
        }
        bottomButton.button.addAction(UIAction(handler: { _ in self.didTapBottomButton(state: state) }), for: .primaryActionTriggered)
    }
    func setUpConstraints(){
        view.addSubview(bookTextLabel)
        bookTextLabel.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
        }
        view.addSubview(bookTextView)
        bookTextView.snp.makeConstraints { make in
            make.top.equalTo(bookTextLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(Constant.screenHeight / 5)
        }
        view.addSubview(myTextLabel)
        myTextLabel.snp.makeConstraints { make in
            make.top.equalTo(bookTextView.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(myTextView)
        myTextView.snp.makeConstraints { make in
            make.top.equalTo(myTextLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(Constant.screenHeight / 5)
        }
        view.addSubview(bottomButton)
        bottomButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
        }
    }
}
private extension CommentAddViewController {
    // MARK: - Method
    func didTapBottomButton(state: Bool) {
        guard let bookText = self.bookTextView.text else { return }
        guard let myText = self.myTextView.text else { return }
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
            AlertMaker.showAlertAction1(vc: self, title: "실패", message: "입력하신 내용을 확인해 주세요.")
        }
    }
}

extension CommentAddViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
