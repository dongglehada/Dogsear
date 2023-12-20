//
//  InfoDisplayView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/20/23.
//

import Foundation
import UIKit

class InfoDisplayView: UIView {
    
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .systemGray4
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body1.font
        label.textColor = .systemGray4
        return label
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = Constant.defaults.padding / 2
        return view
    }()
    
    init(image: UIImage?, description: String) {
        iconImageView.image = image
        descriptionLabel.text = description
        super.init(frame: .zero)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InfoDisplayView {
    func setUpConstraints() {
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(descriptionLabel)
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constant.defaults.blockHeight)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
