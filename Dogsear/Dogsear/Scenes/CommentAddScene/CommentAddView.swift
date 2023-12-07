//
//  CommentAddView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation
import UIKit

class CommentAddView: UIView {
    
    let bookTextLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body1.font
        label.text = "책의 문장"
        return label
    }()
    
    let bookTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = Constant.defaults.radius
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.font = Typography.body2.font
        return view
    }()
    
    let myTextLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body1.font
        label.text = "나의 생각"
        return label
    }()
    
    let myTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = Constant.defaults.radius
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.font = Typography.body2.font
        return view
    }()
    init() {
        super.init(frame: .zero)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CommentAddView {
    func setUpConstraints(){
        self.addSubview(bookTextLabel)
        bookTextLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(bookTextView)
        bookTextView.snp.makeConstraints { make in
            make.top.equalTo(bookTextLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(Constant.screenHeight / 5)
        }
        self.addSubview(myTextLabel)
        myTextLabel.snp.makeConstraints { make in
            make.top.equalTo(bookTextView.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(myTextView)
        myTextView.snp.makeConstraints { make in
            make.top.equalTo(myTextLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(Constant.screenHeight / 5)
        }
    }
}
