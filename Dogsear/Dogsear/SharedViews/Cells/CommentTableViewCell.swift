//
//  CommentCollectionViewCell.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    let trailView = UIView()
    
    let bookTextView: UITextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.font = Typography.title2Medium.font
        view.textAlignment = .center
        view.sizeToFit()
        return view
    }()
    
    let myTextView: UITextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.font = Typography.body2.font
        view.textAlignment = .center
        view.sizeToFit()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
        editAble(state: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension CommentTableViewCell {
    func setUpConstraints() {
        
        contentView.addSubview(trailView)
        trailView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constant.defaults.padding)
        }
        trailView.layer.borderWidth = 1
        trailView.layer.borderColor = UIColor.systemGray4.cgColor
        trailView.layer.cornerRadius = Constant.defaults.radius
        
        trailView.addSubview(bookTextView)
        bookTextView.snp.makeConstraints { make in
            make.width.equalTo(Constant.screenWidth - (Constant.defaults.padding * 2))
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        trailView.addSubview(myTextView)
        myTextView.snp.makeConstraints { make in
            make.top.equalTo(bookTextView.snp.bottom).offset(Constant.defaults.padding)
            make.width.equalTo(Constant.screenWidth - (Constant.defaults.padding * 2))
            make.bottom.centerX.equalToSuperview()
        }
    }
}

extension CommentTableViewCell {
    
    
    func bind(comment: PostBookComment) {
        bookTextView.text = "\"\(comment.bookComment)\""
        myTextView.text = comment.myComment
    }
    
    func editAble(state: Bool) {
        bookTextView.isUserInteractionEnabled = state
        myTextView.isUserInteractionEnabled = state
    }
}
