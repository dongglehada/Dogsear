//
//  ProfileView.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/5/23.
//

import Foundation
import UIKit

class ProfileView: UIView {
    

    init() {
        super.init(frame: .zero)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileView {
    func setUpConstraints() {
        self.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(nickNameDivider)
        nickNameDivider.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(1)
        }
        self.addSubview(versionInfo)
        versionInfo.snp.makeConstraints { make in
            make.top.equalTo(nickNameDivider.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(appIconImageView)
        appIconImageView.snp.makeConstraints { make in
            make.top.equalTo(versionInfo.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
            make.width.height.equalTo(Constant.screenWidth / 5)
        }
        self.addSubview(appInfoStackView)
        appInfoStackView.addArrangedSubview(appNameLabel)
        appInfoStackView.addArrangedSubview(appVersionLabel)
        appInfoStackView.snp.makeConstraints { make in
            make.centerY.equalTo(appIconImageView.snp.centerY)
            make.left.equalTo(appIconImageView.snp.right).offset(Constant.defaults.padding)
        }
        self.addSubview(appInfoDivider)
        appInfoDivider.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(1)
        }
        self.addSubview(developerTitleLabel)
        developerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(appInfoDivider.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(developerLabel)
        developerLabel.snp.makeConstraints { make in
            make.top.equalTo(developerTitleLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        self.addSubview(developerDivider)
        developerDivider.snp.makeConstraints { make in
            make.top.equalTo(developerLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(1)
        }
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(developerDivider.snp.bottom).offset(Constant.defaults.padding)
            make.bottom.equalToSuperview().inset(Constant.defaults.padding)
            make.left.right.equalToSuperview()
        }
    }
}
