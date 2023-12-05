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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body1.font
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body1.font
        return label
    }()
    
    private let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body1.font
        return label
    }()    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body1.font
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BookListTypeCollectionViewCell {
    func setUp() {
        setUpImageView()
        setUpTitleLabel()
        setUpAuthorLabel()
        setUpPublisherLabel()
        setUpDescriptionLabel()
    }
    
    func setUpImageView() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(Constant.bookSize.height)
            make.width.equalTo(Constant.bookSize.width)
            make.left.equalToSuperview().offset(Constant.defaults.padding)
            make.centerY.equalToSuperview()
        }
    }
    
    func setUpTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.left.equalTo(imageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpAuthorLabel() {
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.defaults.padding / 2)
            make.left.equalTo(imageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpPublisherLabel() {
        contentView.addSubview(publisherLabel)
        publisherLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(Constant.defaults.padding / 2)
            make.left.equalTo(imageView.snp.right).offset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    func setUpDescriptionLabel() {
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
        titleLabel.text = "제목: \(item.title)"
        authorLabel.text = "저자: \(item.author)"
        publisherLabel.text = "출판사: \(item.publisher)"
        descriptionLabel.text = "설명: \(item.description)"
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: item.image))
    }
}
