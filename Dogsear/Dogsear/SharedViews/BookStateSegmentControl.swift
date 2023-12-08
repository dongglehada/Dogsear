//
//  BookStateSegmentControl.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import UIKit

class BookStateSegmentControl: UISegmentedControl {
    init() {
        super.init(items: ["읽고 있는 책", "읽은 책", "읽고 싶은 책"])
        self.selectedSegmentIndex = 0
        self.tintColor = .myPointColor
        self.setTitleTextAttributes([
            NSAttributedString.Key.font: Typography.body1.font,
            NSAttributedString.Key.foregroundColor: UIColor.systemGray
        ], for: .normal)
        self.setTitleTextAttributes([
            NSAttributedString.Key.font: Typography.body1.font,
            NSAttributedString.Key.foregroundColor: UIColor.systemBackground
        ], for: .selected)
        self.selectedSegmentTintColor = .myPointColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
