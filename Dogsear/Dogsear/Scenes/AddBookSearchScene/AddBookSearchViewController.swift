//
//  AddBookSearchViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/29/23.
//

import UIKit

class AddBookSearchViewController: BasicController<AddBookSearchViewModel,AddBookSearchView> {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
    }

    override func didTapBottomButton() {
        let rootVC = AddBookViewController()
        rootVC.viewInjection(sceneView: AddBookView())
        rootVC.viewModelInjection(viewModel: AddBookViewModel())
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func bind() {
        viewModel?.searchDatas.bind({ [weak self] data in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.sceneView.activityIndicator.stopAnimating()
                guard let row = self.viewModel?.searchIndex.value else { return }
                self.sceneView.searchCollectionView.reloadData()
            }
        })
    }
}

private extension AddBookSearchViewController {
    func setUp() {
        self.navigationItem.titleViewSetUpLogoImage()
        makeBottomButton(title: "직접 입력하기")
        sceneView?.searchBar.delegate = self
        sceneView?.searchCollectionView.delegate = self
        sceneView?.searchCollectionView.dataSource = self
        sceneView.activityIndicator.center = view.center
    }
}

extension AddBookSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchKeyword = searchBar.text else { return }
        sceneView.activityIndicator.startAnimating()
        viewModel?.searchIndexReset()
        guard let startIndex = viewModel?.searchIndex.value else { return }
        viewModel?.searchManager.getSearchData(searchKeyWord: searchKeyword, start: startIndex, completion: { [weak self] data in
            guard let self = self else { return }
            self.viewModel?.searchDatas.value = data.items
        })
        view.endEditing(true)
    }
}

extension AddBookSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.searchDatas.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListTypeCollectionViewCell.identifier, for: indexPath) as! BookListTypeCollectionViewCell
        guard let safeData = viewModel?.searchDatas.value else { return cell }
        cell.bind(item: safeData[indexPath.row])

        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !sceneView.activityIndicator.isAnimating {
            if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
                sceneView.activityIndicator.startAnimating()
                viewModel?.searchIndexAdd()
                guard let keyword = sceneView.searchBar.text else { return }
                guard let index = viewModel?.searchIndex.value else { return }
                viewModel?.searchManager.getSearchData(searchKeyWord: keyword, start: index, completion: { [weak self] data in
                    guard let self = self else { return }
                    guard let oldData = self.viewModel?.searchDatas.value else { return }
                    self.viewModel?.searchDatas.value = oldData + data.items
                    DispatchQueue.main.async {
                        self.sceneView.activityIndicator.stopAnimating()
                    }
                })
            }
        }
    }
}