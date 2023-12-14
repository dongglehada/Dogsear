//
//  IndicatorMaker.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/14/23.
//

import UIKit

class IndicatorMaker {
    static let loadingIndicatorView = ActivityIndicator()
    
    static func showLoading() {
        DispatchQueue.main.async {
            guard let vc = UIApplication.shared.keyWindow?.visibleViewController else { return }
            
            vc.view.addSubview(loadingIndicatorView)
            loadingIndicatorView.center = vc.view.center
            loadingIndicatorView.startAnimating()
        }
    }
    
    static func hideLoading() {
        DispatchQueue.main.async {
            guard let vc = UIApplication.shared.keyWindow?.visibleViewController else { return }
            loadingIndicatorView.removeFromSuperview()
        }
    }
}
