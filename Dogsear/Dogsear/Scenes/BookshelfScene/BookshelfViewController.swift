//
//  BookshelfViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import UIKit

class BookshelfViewController: BasicController<BookshelfViewModel,BookshelfView> {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewModel?.searchManager.getTranslateData(searchKeyWord: "찰리와", completion: { data in
            print("@@@",data.items)
        })
    }
}

extension BookshelfViewController {
    func setUp() {
        sceneView?.collectionView.delegate = self
        sceneView?.collectionView.dataSource = self
        navigationItem.titleViewSetUpLogoImage()
    }
}

extension BookshelfViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCoverCollectionViewCell.identifier, for: indexPath) as! BookCoverCollectionViewCell
        if indexPath.row == 19 {
            cell.addPostCell()
        } else {
            cell.bind()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 19 {
                    let rootVC = AddBookSearchViewController()
                    rootVC.viewInjection(sceneView: AddBookSearchView())
                    rootVC.viewModelInjection(viewModel: AddBookSearchViewModel())
            navigationController?.pushViewController(rootVC, animated: true)
        }
    }
    
    
}
