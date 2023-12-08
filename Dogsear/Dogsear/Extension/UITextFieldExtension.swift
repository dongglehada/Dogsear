//
//  UITextFieldExtension.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import Foundation
import UIKit

extension UITextField {
    func setUpDefaultTextField() {
        self.backgroundColor = .myPointColor
        self.textColor = .systemBackground
        self.layer.cornerRadius = Constant.defaults.padding
    }
}
