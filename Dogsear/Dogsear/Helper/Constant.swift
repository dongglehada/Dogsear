//
//  Constant.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import UIKit

struct Constant {
    struct Default {
        let padding: CGFloat = 16
        let radius: CGFloat = 4
        let blockHeight: CGFloat = UIScreen.main.bounds.height * 0.05
    }
    static let defaults = Default()
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let width = (screenWidth - (defaults.padding * (3 + 1))) / 3
    static let bookSize = CGSize(width: width, height: width * 1.4)
}


