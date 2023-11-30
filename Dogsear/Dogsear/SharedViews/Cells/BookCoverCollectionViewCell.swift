//
//  BookCoverCollectionViewCell.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import UIKit
import SnapKit

class BookCoverCollectionViewCell: UICollectionViewCell {
    
    private let coverImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .myPointColor
        return view
    }()
    
    private let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body3.font
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookCoverCollectionViewCell {
    
    func setUp(isAddCell: Bool) {
        contentView.addSubview(coverImageView)
        contentView.addSubview(bookTitleLabel)
        coverImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        if isAddCell {
            coverImageView.contentMode = .scaleAspectFit
        } else {
            coverImageView.contentMode = .scaleToFill
        }
    }
    
    func bind() {
        setUp(isAddCell: false)
        coverImageView.image = UIImage(named: "Test")
        bookTitleLabel.text = "TEST"
    }
    
    func addPostCell() {
        setUp(isAddCell: true)
//        self.coverImageView.image = UIImage(systemName: "plus.diamond.fill")
//        self.coverImageView.image = UIImage(systemName: "plus.app.fill")
        self.coverImageView.image = UIImage(systemName: "plus.rectangle.portrait")
//        self.coverImageView.image = UIImage(systemName: "plus.diamond.fill")
//        self.coverImageView.image = UIImage(systemName: "plus.diamond.fill")
    }
}
