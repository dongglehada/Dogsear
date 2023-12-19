//
//  AddBookSearchViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/29/23.
//

import UIKit

class AddBookSearchViewController: BasicController {
    // MARK: - Property
    private let viewModel: AddBookSearchViewModel
    
    // MARK: - Components
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Logo")
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.backgroundImage = UIImage()
        view.placeholder = "책의 이름을 검색해 보세요!"
        return view
    }()
    
    private let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: Constant.screenWidth, height: Constant.defaults.blockHeight * 4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .myPointColor
        return button
    }()
    
    private let bottomButton = SharedButton(title: "직접 입력하기")
    

    init(viewModel: AddBookSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddBookSearchViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
    }
}

private extension AddBookSearchViewController {
    // MARK: - SetUp

    func setUp() {
        searchBar.delegate = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        backButton.addAction(UIAction { _ in self.dismiss(animated: true) }, for: .primaryActionTriggered)
        bottomButton.button.addAction(UIAction(handler: { _ in self.didTapBottomButton() }), for: .primaryActionTriggered)
        setUpConstraints()
    }
    
    func setUpConstraints() {
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
            make.height.equalTo(Constant.defaults.blockHeight)
        }
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.top)
            make.left.equalTo(backButton.snp.right)
            make.right.equalToSuperview().inset(Constant.defaults.padding - 8)
            make.height.equalTo(Constant.defaults.blockHeight)
        }
        
        view.addSubview(searchCollectionView)
        searchCollectionView.register(BookListTypeCollectionViewCell.self, forCellWithReuseIdentifier: BookListTypeCollectionViewCell.identifier)
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(Constant.defaults.padding - 8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constant.defaults.blockHeight + (Constant.defaults.padding * 2))
        }
        
        view.addSubview(bottomButton)
        bottomButton.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
        }
    }
    

}

private extension AddBookSearchViewController {
    // MARK: - Bind
    func bind() {
        viewModel.searchDatas.bind({ [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
            }
        })
    }
}

private extension AddBookSearchViewController {
    // MARK: - Method
    func didTapBottomButton() {
        let rootVC = AddBookViewController(viewModel: AddBookViewModel())
        self.present(rootVC, animated: true)
    }
}

extension AddBookSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchKeyword = searchBar.text else { return }
        IndicatorMaker.showLoading()
        viewModel.searchIndexReset()
        guard let startIndex = viewModel.searchIndex.value else { return }
        viewModel.searchManager.getSearchData(searchKeyWord: searchKeyword, start: startIndex, completion: { [weak self] data in
            guard let self = self else { return }
            self.viewModel.searchDatas.value = data.items
            IndicatorMaker.hideLoading()
        })
        view.endEditing(true)
    }
}

extension AddBookSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchDatas.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListTypeCollectionViewCell.identifier, for: indexPath) as! BookListTypeCollectionViewCell
        guard let safeData = viewModel.searchDatas.value else { return cell }
        cell.bind(item: safeData[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rootVC = AddBookViewController(viewModel: AddBookViewModel())
        guard let datas = viewModel.searchDatas.value else { return }
        rootVC.setUpSearchData(data: datas[indexPath.row])
        self.present(rootVC, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            if viewModel.isLoadingAble {
                viewModel.isLoadingAble = false
                IndicatorMaker.showLoading()
                viewModel.searchIndexAdd()
                guard let keyword = searchBar.text else { return }
                guard let index = viewModel.searchIndex.value else { return }
                viewModel.searchManager.getSearchData(searchKeyWord: keyword, start: index, completion: { [weak self] data in
                    guard let self = self else { return }
                    guard let oldData = self.viewModel.searchDatas.value else { return }
                    self.viewModel.searchDatas.value = oldData + data.items
                    DispatchQueue.main.async {
                        IndicatorMaker.hideLoading()
                        self.viewModel.isLoadingAble = true
                    }
                })
            }
        }
    }
}
