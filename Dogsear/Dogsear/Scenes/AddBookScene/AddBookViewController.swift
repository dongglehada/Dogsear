//
//  AddBookViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import UIKit
import PhotosUI

class AddBookViewController: UIViewController {
    // MARK: - Property
    private let viewModel: AddBookViewModel
    
    // MARK: - Components

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body2.font
        label.textColor = .black
        label.text = "표지 이미지"
        return label
    }()
    
    private let imageAddButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constant.defaults.radius
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.myPointColor.cgColor
        let image = UIImage(systemName: "plus")
        button.tintColor = .myPointColor
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let nameTextField = SharedTextField(type: .title, placeHolder: "제목을 입력해주세요.", title: "제목")
    private let authorTextField = SharedTextField(type: .title, placeHolder: "저자를 입력해주세요.", title: "저자명")
    private let publisherTextField = SharedTextField(type: .title, placeHolder: "출판사를 입력해주세요.", title: "출판사")
    private let bottomButton = SharedButton(title: "추가 하기")
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body2.font
        label.textColor = .black
        label.text = "이 책은"
        return label
    }()
    
    private let segmentedControl = BookStateSegmentControl()
    
    init(viewModel: AddBookViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AddBookViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
    }
}

private extension AddBookViewController {
    // MARK: - SetUp

    func setUp() {
        setUpConstraints()
        setUpDelegate()
        setUpAddAction()
        navigationItem.title = "추가 하기"
        view.backgroundColor = .systemBackground
    }
    
    func setUpAddAction() {
        bottomButton.button.addAction(UIAction(handler: { _ in self.didTapBottomButton()}), for: .primaryActionTriggered)
        imageAddButton.addAction(UIAction(handler: { _ in self.didTapImageButton()}), for: .primaryActionTriggered)
        segmentedControl.addAction(UIAction(handler: { _ in self.didChangeValue(segment: self.segmentedControl)}), for: .primaryActionTriggered)
    }
    func setUpDelegate() {
        nameTextField.textField.delegate = self
        authorTextField.textField.delegate = self
        publisherTextField.textField.delegate = self
    }
    
    func setUpConstraints() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.blockHeight + (Constant.defaults.padding * 2))
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        contentView.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        contentView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        contentView.addSubview(imageLabel)
        imageLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        contentView.addSubview(imageAddButton)
        imageAddButton.snp.makeConstraints { make in
            make.top.equalTo(imageLabel.snp.bottom).offset(Constant.defaults.padding)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constant.bookSize.width * 2)
            make.height.equalTo(Constant.bookSize.height * 2)
        }
        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageAddButton.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        contentView.addSubview(authorTextField)
        authorTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        contentView.addSubview(publisherTextField)
        publisherTextField.snp.makeConstraints { make in
            make.top.equalTo(authorTextField.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.bottom.equalToSuperview()
        }
        view.addSubview(bottomButton)
        bottomButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
        }
    }
}

private extension AddBookViewController {
    // MARK: - bind
    func bind() {
        viewModel.newPost.bind({ [weak self] postBook in
            guard let self = self else { return }
            guard let postBook = postBook else { return }
            if postBook.title == "" {
                nameTextField.changeBorderColor(color: .systemGray4, animated: true)
            } else {
                nameTextField.changeBorderColor(color: .myPointColor, animated: true)
            }
            if postBook.author == "" {
                authorTextField.changeBorderColor(color: .systemGray4, animated: true)
            } else {
                authorTextField.changeBorderColor(color: .myPointColor, animated: true)
            }
            if postBook.publisher == "" {
                publisherTextField.changeBorderColor(color: .systemGray4, animated: true)
            } else {
                publisherTextField.changeBorderColor(color: .myPointColor, animated: true)
            }
        })
    }
}

private extension AddBookViewController {
    // MARK: - Method
    
    func didTapImageButton() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func didChangeValue(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            viewModel.newPost.value?.state = .reading
        case 1:
            viewModel.newPost.value?.state = .complete
        case 2:
            viewModel.newPost.value?.state = .expected
        default:
            print("등록되지 않은 State")
        }
    }
    
    func didTapBottomButton() {
        guard let newPost = viewModel.newPost.value else { return }

        if newPost.title != "" && newPost.author != "" && newPost.publisher != "" && newPost.imageUrl?.absoluteString != "" {
            viewModel.firebaseManager.createBookPost(newPost: newPost) {
                self.dismiss(animated: true)
            }
        } else {
            AlertMaker.showAlertAction1(title: "입력하신 정보를 확인해 주세요.")
        }
    }

}

extension AddBookViewController {
    func setUpSearchData(data: SearchData) {
        viewModel.newPost.value?.imageUrl = URL(string: data.image)
        viewModel.newPost.value?.title = data.title
        viewModel.newPost.value?.author = data.author
        viewModel.newPost.value?.publisher = data.publisher
        imageAddButton.kf.setImage(with: URL(string: data.image), for: .normal)
        nameTextField.textField.text = data.title
        authorTextField.textField.text = data.author
        publisherTextField.textField.text = data.publisher
    }
}

extension AddBookViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField {
        case nameTextField.textField:
            viewModel.newPost.value?.title = text
        case authorTextField.textField:
            viewModel.newPost.value?.author = text
        case publisherTextField.textField:
            viewModel.newPost.value?.publisher = text
        default:
            print("등록되지 않은 textField")
        }
    }
}

extension AddBookViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in // 4
                DispatchQueue.main.async {
                    self.imageAddButton.setImage(image as? UIImage, for: .normal)
                    self.viewModel.firebaseManager.uploadImage(image: image as? UIImage, completion: { url in
                        if let url = url {
                            self.viewModel.newPost.value?.imageUrl = url
                        }
                    })
                }
            }
        }
    }
}
