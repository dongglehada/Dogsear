//
//  AddBookView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import Foundation
import UIKit

class AddBookView: UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body2.font
        label.textColor = .black
        label.text = "표지 이미지"
        return label
    }()
    
    let imageAddButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constant.defaults.radius
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.myPointColor.cgColor
        let image = UIImage(systemName: "plus")
        button.tintColor = .myPointColor
        button.setImage(image, for: .normal)
        return button
    }()
    
    let nameTextField = SharedTextField(type: .title, placeHolder: "제목을 입력해주세요.", title: "제목")
    let authorTextField = SharedTextField(type: .title, placeHolder: "저자를 입력해주세요.", title: "저자명")
    let publisherTextField = SharedTextField(type: .title, placeHolder: "출판사를 입력해주세요.", title: "출판사")
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body2.font
        label.textColor = .black
        label.text = "이 책은"
        return label
    }()
    
    let segmentedControl = BookStateSegmentControl()
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddBookView {
    func setUp() {
        setUpScrollView()
        setUpImageLabel()
        setUpImageAddButton()
        setUpNameTextField()
        setUpAuthorTextField()
        setUpPublisherTextField()
        setUpStateLabel()
        setUpStateCollectionView()
    }
    
    func setUpScrollView() {
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constant.defaults.blockHeight + (Constant.defaults.padding * 2))
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
    }
    
    func setUpImageLabel() {
        contentView.addSubview(imageLabel)
        imageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpImageAddButton() {
        contentView.addSubview(imageAddButton)
        imageAddButton.snp.makeConstraints { make in
            make.top.equalTo(imageLabel.snp.bottom).offset(Constant.defaults.padding)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constant.bookSize.width * 2)
            make.height.equalTo(Constant.bookSize.height * 2)
        }
    }
    
    func setUpNameTextField() {
        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageAddButton.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpAuthorTextField() {
        contentView.addSubview(authorTextField)
        authorTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpPublisherTextField() {
        contentView.addSubview(publisherTextField)
        publisherTextField.snp.makeConstraints { make in
            make.top.equalTo(authorTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpStateLabel() {
        contentView.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(publisherTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpStateCollectionView() {
        contentView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottom).offset(Constant.defaults.padding)
            make.height.equalTo(Constant.defaults.blockHeight)
            make.left.right.bottom.equalToSuperview().inset(Constant.defaults.padding)
        }
    }

}
