//
//  TestController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/13/23.
//

import Foundation
import UIKit

class TestController: UIViewController {
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "books.vertical")
        view.contentMode = .scaleAspectFit
        return view
        
    }()
    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}
