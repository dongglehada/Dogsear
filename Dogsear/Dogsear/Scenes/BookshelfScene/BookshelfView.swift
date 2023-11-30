//
//  BookshelfView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import UIKit

class BookshelfView: UIView {
    
    let segmentedControl = BookStateSegmentControl()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let itemCount: CGFloat = 3
        layout.itemSize = Constant.bookSize
        layout.minimumLineSpacing = Constant.defaults.padding
        layout.minimumInteritemSpacing = Constant.defaults.padding
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
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

private extension BookshelfView {
    func setUp() {
        setUpSegmentedControl()
        setUpCollectionView()
    }
    
    func setUpSegmentedControl() {
        self.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
    
    func setUpCollectionView() {
        self.addSubview(collectionView)
        collectionView.register(BookCoverCollectionViewCell.self, forCellWithReuseIdentifier: BookCoverCollectionViewCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.bottom.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
}
