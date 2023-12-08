//
//  SharedButton.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/24/23.
//

import UIKit

class SharedButton: UIView {
    
    let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    init(title:String){
        super.init(frame: .zero)
        button.setTitle(title, for: .normal)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SharedButton {
    func setUp() {
        button.titleLabel?.font = Typography.body1.font
        button.backgroundColor = .myPointColor
        button.layer.cornerRadius = Constant.defaults.radius
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(Constant.defaults.blockHeight)
        }
    }
}
