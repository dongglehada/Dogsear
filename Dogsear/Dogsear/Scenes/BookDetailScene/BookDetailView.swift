//
//  BookDetailView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation
import UIKit

class BookDetailView: UIView {
    
    let bookStateSegmentControl = BookStateSegmentControl()
    let bookImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        return view
    }()
    
    let titleTextField = BottomLineTextField(placeHolder: "제목을 입력해 주세요.", text: "test", font: Typography.title3.font)
    let authorTextField = BottomLineTextField(placeHolder: "저자를 입력해 주세요.", text: "test")
    let publisherTextField = BottomLineTextField(placeHolder: "출판사를 입력해 주세요.", text: "test")
    let recordButton = SharedButton(title: "기록하기")
    let commentTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setUpConstraints()
        isEditAble(state: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BookDetailView {
    

    func setUpConstraints() {

        self.addSubview(bookStateSegmentControl)
        bookStateSegmentControl.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(bookImageView)
        bookImageView.snp.makeConstraints { make in
            make.height.equalTo(Constant.bookSize.height)
            make.width.equalTo(Constant.bookSize.width)
            make.top.equalTo(bookStateSegmentControl.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.top)
            make.left.equalTo(bookImageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(authorTextField)
        authorTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(Constant.defaults.padding / 2)
            make.left.equalTo(bookImageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }        
        self.addSubview(publisherTextField)
        publisherTextField.snp.makeConstraints { make in
            make.top.equalTo(authorTextField.snp.bottom).offset(Constant.defaults.padding / 2)
            make.left.equalTo(bookImageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(recordButton)
        recordButton.snp.makeConstraints { make in
            make.top.equalTo(publisherTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalTo(bookImageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
            make.bottom.equalTo(bookImageView.snp.bottom)
        }
        self.addSubview(commentTableView)
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(recordButton.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.bottom.equalToSuperview()
        }
    }
}

extension BookDetailView {
    // MARK: - Method
    func isEditAble(state: Bool) {
        bookStateSegmentControl.isUserInteractionEnabled = state
        titleTextField.textField.isEnabled = state
        authorTextField.textField.isEnabled = state
        publisherTextField.textField.isEnabled = state
    }

}
