//
//  BookDetailViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/7/23.
//

import Foundation

class BookDetailViewController: BasicController<BookDetailViewModel, BookDetailView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension BookDetailViewController {
    // MARK: - Method
    func setUp() {
        sceneView.bookImageView.kf.setImage(with: viewModel?.postData.value?.imageUrl)
        sceneView.titleTextField.textField.text = viewModel?.postData.value?.title
        sceneView.authorTextField.textField.text = "저자 " + (viewModel?.postData.value?.author ?? "")
        sceneView.publisherTextField.textField.text = "출판사 " + (viewModel?.postData.value?.publisher ?? "")
        guard let state = viewModel?.postData.value?.state else { return }
        var tempIndex = 0
        switch state {
        case .reading:
            tempIndex = 0
        case .complete:
            tempIndex = 1
        case .expected:
            tempIndex = 2
        }
        sceneView.bookStateSegmentControl.selectedSegmentIndex = tempIndex
    }

}
