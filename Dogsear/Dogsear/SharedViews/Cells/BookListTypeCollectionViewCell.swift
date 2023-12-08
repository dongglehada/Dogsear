//
//  BookListTypeCollectionViewCell.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import Foundation
import UIKit
import SnapKit

class BookListTypeCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let titleLabel = BottomLineTextField(placeHolder: "", text: "", font: Typography.title3.font)
    private let authorLabel = BottomLineTextField(placeHolder: "", text: "")
    private let publisherLabel = BottomLineTextField(placeHolder: "", text: "")
    private let descriptionLabel = BottomLineTextField(placeHolder: "", text: "")
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setUpConstraints()
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BookListTypeCollectionViewCell {
    
    func setUp() {
        titleLabel.textField.isEnabled = false
        authorLabel.textField.isEnabled = false
        publisherLabel.textField.isEnabled = false
        descriptionLabel.textField.isEnabled = false
    }
    
    func setUpConstraints() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(Constant.bookSize.height)
            make.width.equalTo(Constant.bookSize.width)
            make.left.equalToSuperview().offset(Constant.defaults.padding)
            make.centerY.equalToSuperview()
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.left.equalTo(imageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.defaults.padding / 2)
            make.left.equalTo(imageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        contentView.addSubview(publisherLabel)
        publisherLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(Constant.defaults.padding / 2)
            make.left.equalTo(imageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(publisherLabel.snp.bottom).offset(Constant.defaults.padding / 2)
            make.left.equalTo(imageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
            make.bottom.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
}

extension BookListTypeCollectionViewCell {
    func bind(item: SearchData) {
        titleLabel.textField.text = "\(item.title)"
        authorLabel.textField.text = "저자: \(item.author)"
        publisherLabel.textField.text = "출판사: \(item.publisher)"
        descriptionLabel.textField.text = "설명: \(item.description)"
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: item.image))
    }
}
