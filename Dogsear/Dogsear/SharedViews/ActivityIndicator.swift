//
//  activityIndicator.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import Foundation
import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    init() {
        super.init(frame: .zero)
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.color = .myPointColor
        self.hidesWhenStopped = true
        self.style = .medium
        // stopAnimating을 걸어주는 이유는, 최초에 해당 indicator가 선언되었을 때, 멈춘 상태로 있기 위해서
        self.stopAnimating()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
