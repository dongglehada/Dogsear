//
//  UINavigationItemExtension.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import UIKit

extension UINavigationItem {
    func titleViewSetUpLogoImage() {
        let imageView: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "Logo")
            view.contentMode = .scaleAspectFit
            return view
        }()
        self.titleView = imageView
    }
}
