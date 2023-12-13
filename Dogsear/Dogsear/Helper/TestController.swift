//
//  TestController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/13/23.
//

import Foundation
import UIKit

class TestController: UIViewController {
    let searchManager = BookSearchManager()
    override func viewDidLoad() {
        self.view.backgroundColor = .blue
        for i in 1...10 {
            let timer = MyTimer()
            searchManager.getSearchData(searchKeyWord: "하루", start: 1) { _ in
                timer.stopTimer()
            }
        }
        
    }
}
