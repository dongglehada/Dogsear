//
//  BookshelfViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import UIKit

class BookshelfViewController: BasicController {
    
    // MARK: - Property
    private var viewModel: BookshelfViewModel
    
    // MARK: - Components
    private let segmentedControl = BookStateSegmentControl()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        IndicatorMaker.showLoading()
        viewModel.firebaseManager.fetchUserData(completion: { [weak self] user in
            guard let self = self else { return }
            self.viewModel.originPostBooks = user.PostBooks
            self.fetchPostBooksAry(segment: segmentedControl)
            IndicatorMaker.hideLoading()
        })
    }
}

private extension BookshelfViewController {
    // MARK: - SetUp
    func setUp() {
        collectionView.delegate = self
        collectionView.dataSource = self
        segmentedControl.addTarget(self, action: #selector(didchangeValue(segment:)), for: .valueChanged)
        navigationItem.titleViewSetUpLogoImage()
        setUpConstraints()
    }
    
    func setUpConstraints() {
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        view.addSubview(collectionView)
        collectionView.register(BookCoverCollectionViewCell.self, forCellWithReuseIdentifier: BookCoverCollectionViewCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Constant.defaults.padding)
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
    }
}

private extension BookshelfViewController {
    // MARK: - Method
    @objc func didchangeValue(segment: UISegmentedControl) {
        fetchPostBooksAry(segment: segment)
    }
    
    @objc func didTapAddButton() {
        let rootVC = AddBookSearchViewController(viewModel: AddBookSearchViewModel())
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func fetchPostBooksAry(segment: UISegmentedControl) {
        var data: [PostBook] = []
        switch segment.selectedSegmentIndex {
        case 0:
            data = self.viewModel.originPostBooks.filter({$0.state == .reading})
        case 1:
            data = self.viewModel.originPostBooks.filter({$0.state == .complete})
        case 2:
            data = self.viewModel.originPostBooks.filter({$0.state == .expected})
        default:
            print("등록되지 않은 state")
        }
        self.viewModel.postBooks.value = data
        if data.isEmpty {
            infoDisplayView.isHidden = false
        } else {
            infoDisplayView.isHidden = true
        }
    }
}

extension BookshelfViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let postBookAry = viewModel.postBooks.value else { return 0 }
        return postBookAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCoverCollectionViewCell.identifier, for: indexPath) as! BookCoverCollectionViewCell
        guard let postBookAry = viewModel.postBooks.value else { return cell }
        cell.bind(postBook: postBookAry[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let postBookAry = viewModel.postBooks.value else { return }
        let vc = BookDetailViewController(viewModel: BookDetailViewModel(postData: Observable(postBookAry[indexPath.row])))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
