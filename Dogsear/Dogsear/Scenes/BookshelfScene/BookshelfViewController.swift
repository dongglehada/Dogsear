//
//  BookshelfViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import UIKit
import Foundation

class BookshelfViewController: BasicController {
    
    // MARK: - Property
    private var viewModel: BookshelfViewModel
    
    // MARK: - Components
    private let segmentedControl = BookStateSegmentControl()
    
    lazy var listViewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        return button
    }()
    
    lazy var galleryViewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let bookCountLabel: UILabel = {
        let label = UILabel()
        label.text = "책장에 0권의 책이 있어요."
        label.font = Typography.body2.font
        label.textColor = .systemGray4
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundImage = UIImage()
        bar.placeholder = "책장에 0권의 책이 있어요."
        bar.searchTextField.backgroundColor = .clear
        return bar
    }()
    
    private let collectionView: UICollectionView = {
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
    
    private let infoDisplayView = InfoDisplayView(image: UIImage(systemName: "books.vertical"), description: "책장에 등록되어 있는 책이 없습니다.")
    
    init(viewModel: BookshelfViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookshelfViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
        viewModel.userDefaultsManager.setIsListView(value: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        IndicatorMaker.showLoading()
        viewModel.firebaseManager.fetchUserData(completion: { [weak self] user in
            guard let self = self else { return }
            self.viewModel.originPostBooks = user.PostBooks
            viewModel.fetchSearhData(segment: segmentedControl, searchText: searchBar.text ?? "")
            self.isOnEmptyDisplay()
            setBookCount()
            IndicatorMaker.hideLoading()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}

private extension BookshelfViewController {
    // MARK: - SetUp
    func setUp() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        setUpAddTarget()
        setUpConstraints()
    }
    
    func setUpAddTarget() {
        segmentedControl.addTarget(self, action: #selector(didchangeValue(segment:)), for: .valueChanged)
        listViewButton.addTarget(self, action: #selector(didTapListViewButton), for: .primaryActionTriggered)
        galleryViewButton.addTarget(self, action: #selector(didTapGalleryViewButton), for: .primaryActionTriggered)
    }
    
    func setUpConstraints() {
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(galleryViewButton)
        galleryViewButton.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.width.equalTo(Constant.defaults.blockHeight)
        }
        view.addSubview(listViewButton)
        listViewButton.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.right.equalTo(galleryViewButton.snp.left)
            make.height.width.equalTo(Constant.defaults.blockHeight)
        }
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.centerY.equalTo(galleryViewButton.snp.centerY)
            make.left.equalToSuperview().inset(Constant.defaults.padding - 10)
            make.right.equalTo(listViewButton.snp.left)
        }
        view.addSubview(collectionView)
        collectionView.register(BookCoverCollectionViewCell.self, forCellWithReuseIdentifier: BookCoverCollectionViewCell.identifier)
        collectionView.register(BookListTypeCollectionViewCell.self, forCellWithReuseIdentifier: BookListTypeCollectionViewCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(listViewButton.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
        }
        
        view.addSubview(infoDisplayView)
        infoDisplayView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
        }
    }
}

private extension BookshelfViewController {
    // MARK: - Bind
    func bind() {
        viewModel.postBooks.bind({[weak self] _ in
            self?.collectionView.reloadData()
        })
        
        viewModel.isListviewType.bind { [weak self] value in
            guard let value = value else { return }
            self?.viewModel.userDefaultsManager.setIsListView(value: value)
            self?.changeViewButtonColor(isListView: value)
            self?.collectionView.reloadData()
        }
    }
}

private extension BookshelfViewController {
    // MARK: - Method
    @objc 
    func didchangeValue(segment: UISegmentedControl) {
        viewModel.fetchPostBooksAry(segment: segment)
        isOnEmptyDisplay()
        setBookCount()
    }
    
    @objc 
    func didTapAddButton() {
        let rootVC = AddBookSearchViewController(viewModel: AddBookSearchViewModel())
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc
    func didTapListViewButton() {
        viewModel.isListviewType.value = true
    }
    
    @objc
    func didTapGalleryViewButton() {
        viewModel.isListviewType.value = false
    }
    
    func changeViewButtonColor(isListView: Bool) {
        if isListView {
            listViewButton.tintColor = .myPointColor
            galleryViewButton.tintColor = .systemGray4
        } else {
            listViewButton.tintColor = .systemGray4
            galleryViewButton.tintColor = .myPointColor
        }
    }
    
    func isOnEmptyDisplay() {
        guard let isEmpty = viewModel.postBooks.value?.isEmpty else { return }
        if isEmpty {
            infoDisplayView.isHidden = false
        } else {
            infoDisplayView.isHidden = true
        }
    }
    
    func setBookCount() {
        guard let count = self.viewModel.postBooks.value?.count else { return }
        searchBar.placeholder = "책장에 \(count)권의 책이 있어요."
    }
}

extension BookshelfViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let postBookAry = viewModel.postBooks.value else { return 0 }
        return postBookAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let isListViewType = viewModel.isListviewType.value else { return UICollectionViewCell() }
        
        if isListViewType {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListTypeCollectionViewCell.identifier, for: indexPath) as! BookListTypeCollectionViewCell
            guard let postBookAry = viewModel.postBooks.value else { return cell }
            cell.postBookDataBind(item: postBookAry[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCoverCollectionViewCell.identifier, for: indexPath) as! BookCoverCollectionViewCell
            guard let postBookAry = viewModel.postBooks.value else { return cell }
            cell.bind(postBook: postBookAry[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let postBookAry = viewModel.postBooks.value else { return }
        let vc = BookDetailViewController(viewModel: BookDetailViewModel(postData: Observable(postBookAry[indexPath.row])))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}

extension BookshelfViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let isListViewType = viewModel.isListviewType.value else { return CGSize(width: 0, height: 0) }
        
        if isListViewType {
            return .init(width: Constant.screenWidth, height: Constant.defaults.blockHeight * 4)
        } else {
            return Constant.bookSize
        }
    }
}

extension BookshelfViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchSearhData(segment: segmentedControl, searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
