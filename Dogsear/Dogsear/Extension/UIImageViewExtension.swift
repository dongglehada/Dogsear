//
//  UIImageViewExtension.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import Foundation
import UIKit

extension UIImageView {
    func load(stringUrl: String) {
        let indicator = ActivityIndicator()
        self.addSubview(indicator)
        indicator.center = self.center
        indicator.startAnimating()
        guard let url = URL(string: stringUrl) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        indicator.stopAnimating()
                    }
                }
            }
        }
    }
}
