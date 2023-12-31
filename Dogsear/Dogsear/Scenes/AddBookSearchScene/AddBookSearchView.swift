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
    
    let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: Constant.screenWidth, height: Constant.defaults.blockHeight * 4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .myPointColor
        return button
    }()
    
    init() {
        super.init(frame: .zero)
//        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddBookSearchView {
    
    func setUpConstraints() {
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(Constant.defaults.blockHeight)
        }
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.top)
            make.left.equalTo(backButton.snp.right)
            make.right.equalToSuperview().inset(Constant.defaults.padding - 8)
            make.height.equalTo(Constant.defaults.blockHeight)
        }
        
        self.addSubview(searchCollectionView)
        searchCollectionView.register(BookListTypeCollectionViewCell.self, forCellWithReuseIdentifier: BookListTypeCollectionViewCell.identifier)
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(Constant.defaults.padding - 8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constant.defaults.blockHeight + (Constant.defaults.padding * 2))
        }
    }
}
