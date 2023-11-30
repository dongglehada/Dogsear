//
//  AddBookSearchView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/29/23.
//

import Foundation
import UIKit

class AddBookSearchView: UIView {
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Logo")
        return view
    }()
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.backgroundImage = UIImage()
        view.placeholder = "책의 이름을 검색해 보세요!"
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddBookSearchView {
    
    func setUp() {
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.defaults.padding - 8)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding - 8)
            make.height.equalTo(Constant.defaults.blockHeight)
        }
    }
}
