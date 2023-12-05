//
//  AddBookViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import UIKit
import PhotosUI

class AddBookViewController: BasicController<AddBookViewModel,AddBookView> {
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
        setUpDelegate()
        sceneView.imageAddButton.addTarget(self, action: #selector(didTapImageButton), for: .touchUpInside)
        sceneView.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        navigationItem.title = "추가 하기"
        makeBottomButton(title: "추가 하기") { [weak self] in
            self?.didTapBottomButton()
        }
    }
    
    func setUpDelegate() {
        sceneView.nameTextField.textField.delegate = self
        sceneView.authorTextField.textField.delegate = self
        sceneView.publisherTextField.textField.delegate = self
    }
    
    // MARK: - bind
    
    func bind() {
        viewModel?.newPost.bind({ [weak self] postBook in
            guard let self = self else { return }
            guard let postBook = postBook else { return }
            if postBook.title == "" {
                sceneView.nameTextField.changeBorderColor(color: .systemGray4, animated: true)
            } else {
                sceneView.nameTextField.changeBorderColor(color: .myPointColor, animated: true)
            }
            if postBook.author == "" {
                sceneView.authorTextField.changeBorderColor(color: .systemGray4, animated: true)
            } else {
                sceneView.authorTextField.changeBorderColor(color: .myPointColor, animated: true)
            }
            if postBook.publisher == "" {
                sceneView.publisherTextField.changeBorderColor(color: .systemGray4, animated: true)
            } else {
                sceneView.publisherTextField.changeBorderColor(color: .myPointColor, animated: true)
            }
        })
    }

}

private extension AddBookViewController {
    // MARK: - private Method
    
    @objc func didTapImageButton() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @objc func didChangeValue(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            viewModel?.newPost.value?.state = .reading
        case 1:
            viewModel?.newPost.value?.state = .complete
        case 2:
            viewModel?.newPost.value?.state = .expected
        default:
            print("등록되지 않은 State")
        }
    }
    
    func didTapBottomButton() {
        guard let viewModel = viewModel else { return }
        guard let newPost = viewModel.newPost.value else { return }

        if newPost.title != "" && newPost.author != "" && newPost.publisher != "" && newPost.imageUrl?.absoluteString != "" {
            viewModel.firebaseManager.creatNewBookPost(newPost: newPost) {
                guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                for viewController in viewControllerStack {
                    if let targetVC = viewController as? BookshelfViewController {
                        self.navigationController?.popToViewController(targetVC, animated: true)
                    }
                }
            }
        } else {
            makeAlert(title: "입력하신 정보를 확인해 주세요.", message: nil)
        }
    }

}

extension AddBookViewController {
    func setUpSearchData(data: SearchData) {
        viewModel?.newPost.value?.imageUrl = URL(string: data.image)
        viewModel?.newPost.value?.title = data.title
        viewModel?.newPost.value?.author = data.author
        viewModel?.newPost.value?.publisher = data.publisher
        sceneView.imageAddButton.kf.setImage(with: URL(string: data.image), for: .normal)
        sceneView.nameTextField.textField.text = data.title
        sceneView.authorTextField.textField.text = data.author
        sceneView.publisherTextField.textField.text = data.publisher
    }
}

extension AddBookViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField {
        case sceneView.nameTextField.textField:
            viewModel?.newPost.value?.title = text
        case sceneView.authorTextField.textField:
            viewModel?.newPost.value?.author = text
        case sceneView.publisherTextField.textField:
            viewModel?.newPost.value?.publisher = text
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
                    self.sceneView.imageAddButton.setImage(image as? UIImage, for: .normal)
                    self.viewModel?.firebaseManager.uploadImage(image: image as? UIImage, completion: { url in
                        if let url = url {
                            self.viewModel?.newPost.value?.imageUrl = url
                        }
                    })
                }
            }
        }
    }
}
