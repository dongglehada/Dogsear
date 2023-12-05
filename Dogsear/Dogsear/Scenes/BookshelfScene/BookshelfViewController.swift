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
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        viewModel?.firebaseManager.fetchUserData(completion: { [weak self] user in
            guard let self = self else { return }
            self.viewModel?.originPostBooks = user.PostBooks
            self.fetchPostBooksAry(segment: sceneView.segmentedControl)
        })
    }
}

private extension BookshelfViewController {
    // MARK: - SetUp
    func setUp() {
        sceneView?.collectionView.delegate = self
        sceneView?.collectionView.dataSource = self
        sceneView.segmentedControl.addTarget(self, action: #selector(didchangeValue(segment:)), for: .valueChanged)
        navigationItem.titleViewSetUpLogoImage()
    }
    // MARK: - Bind
    
    func bind() {
        viewModel?.postBooks.bind({ _ in
            self.sceneView.collectionView.reloadData()
        })
    }

}

private extension BookshelfViewController {
    // MARK: - Method
    @objc func didchangeValue(segment: UISegmentedControl) {
        fetchPostBooksAry(segment: segment)
    }
    func fetchPostBooksAry(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            self.viewModel?.postBooks.value = self.viewModel?.originPostBooks.filter({$0.state == .reading})
        case 1:
            self.viewModel?.postBooks.value = self.viewModel?.originPostBooks.filter({$0.state == .complete})
        case 2:
            self.viewModel?.postBooks.value = self.viewModel?.originPostBooks.filter({$0.state == .expected})
        default:
            print("등록되지 않은 state")
        }
    }
}

extension BookshelfViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let postBookAry = viewModel?.postBooks.value else { return 0 }
        return postBookAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCoverCollectionViewCell.identifier, for: indexPath) as! BookCoverCollectionViewCell
        guard let postBookAry = viewModel?.postBooks.value else { return cell }
        cell.bind(postBook: postBookAry[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let postBookAry = viewModel?.postBooks.value else { return  }
        if indexPath.row == postBookAry.count {
                    let rootVC = AddBookSearchViewController()
                    rootVC.viewInjection(sceneView: AddBookSearchView())
                    rootVC.viewModelInjection(viewModel: AddBookSearchViewModel())
            navigationController?.pushViewController(rootVC, animated: true)
        }
    }
    
    
}
