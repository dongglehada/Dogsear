//
//  BookshelfView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import UIKit

class BookshelfView: UIView {
    // MARK: - Property

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
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .myPointColor
        button.tintColor = .white
        return button
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
    // MARK: - SetUp

    func setUp() {
        setUpSegmentedControl()
        setUpCollectionView()
        setUpAddButton()
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
    
    func setUpAddButton() {
        self.addSubview(addButton)
        addButton.layer.cornerRadius = (Constant.screenWidth / 6) / 2
        addButton.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(Constant.defaults.padding)
            make.height.width.equalTo(Constant.screenWidth / 6)
        }
    }
    
}
