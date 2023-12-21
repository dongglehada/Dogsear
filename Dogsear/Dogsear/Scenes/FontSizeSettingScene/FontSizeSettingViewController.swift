//
//  FontSizeSettingViewController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/21/23.
//

import Foundation
import UIKit

class FontSizeSettingViewController: BasicController {
    // MARK: - Property
    private let viewModel: FontSizeSettingViewModel
    // MARK: - Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body2.font
        label.text = "기록하기 폰트 크기 설정"
        return label
    }()
    
    private let titleDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .myPointColor
        return view
    }()
    
    private let commentBookDisplayLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.commentBook.font
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "\"책의 문장\""
        return label
    }()
    
    private let commentMyDisplayLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.commentMy.font
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "나의 생각"
        return label
    }()
    
    private let sliderDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .myPointColor
        return view
    }()
    
    private let bookSliderLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body2.font
        label.text = "책의 문장"
        return label
    }()
    
    private let bookSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .myPointColor
        slider.value = Float(UserDefaultsManager.getBookFontSize())
        return slider
    }()
    
    private let mySliderLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body2.font
        label.text = "나의 생각"
        return label
    }()
    
    private let mySlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .myPointColor
        slider.value = Float(UserDefaultsManager.getMyFontSize())
        return slider
    }()
    
    private let bottomButton = SharedButton(title: "초기화")
    
    init(viewModel: FontSizeSettingViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FontSizeSettingViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

private extension FontSizeSettingViewController {
    // MARK: - SetUp
    
    func setUp() {
        bookSlider.addTarget(self, action: #selector(didChangeBookSlider(sender: )), for: .valueChanged)
        mySlider.addTarget(self, action: #selector(didChangeMySlider(sender: )), for: .valueChanged)
        bottomButton.button.addTarget(self, action: #selector(didTapBottomButton), for: .primaryActionTriggered)
    }

    func setUpConstraints() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
        }
        view.addSubview(titleDivider)
        titleDivider.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(1)
        }
        view.addSubview(commentBookDisplayLabel)
        commentBookDisplayLabel.snp.makeConstraints { make in
            make.top.equalTo(titleDivider.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.centerX.equalToSuperview()
        }
        view.addSubview(commentMyDisplayLabel)
        commentMyDisplayLabel.snp.makeConstraints { make in
            make.top.equalTo(commentBookDisplayLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        view.addSubview(sliderDivider)
        sliderDivider.snp.makeConstraints { make in
            make.top.equalTo(commentMyDisplayLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(1)
        }
        
        view.addSubview(bookSliderLabel)
        bookSliderLabel.snp.makeConstraints { make in
            make.top.equalTo(sliderDivider.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        view.addSubview(bookSlider)
        bookSlider.snp.makeConstraints { make in
            make.top.equalTo(bookSliderLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
            make.height.equalTo(Constant.defaults.blockHeight)
        }
        
        view.addSubview(mySliderLabel)
        mySliderLabel.snp.makeConstraints { make in
            make.top.equalTo(bookSlider.snp.bottom).offset(Constant.defaults.padding)
            make.left.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        view.addSubview(mySlider)
        mySlider.snp.makeConstraints { make in
            make.top.equalTo(mySliderLabel.snp.bottom).offset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
        
        view.addSubview(bottomButton)
        bottomButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constant.defaults.padding)
            make.left.right.equalToSuperview().inset(Constant.defaults.padding)
        }
    }
}
private extension FontSizeSettingViewController {
    // MARK: - Method

    @objc
    func didChangeBookSlider(sender: UISlider) {
        let manager = UserDefaultsManager()
        let value = Double(sender.value)
        manager.setBookFontSize(value: value)
        commentBookDisplayLabel.font = Typography.commentBook.font
    }
    
    @objc
    func didChangeMySlider(sender: UISlider) {
        let manager = UserDefaultsManager()
        let value = Double(sender.value)
        manager.setMyFontSize(value: value)
        commentMyDisplayLabel.font = Typography.commentMy.font
    }
    
    @objc
    func didTapBottomButton() {
        let manager = UserDefaultsManager()
        manager.setBookFontSize(value: 0)
        manager.setMyFontSize(value: 0)
        bookSlider.value = 0
        mySlider.value = 0
        commentBookDisplayLabel.font = Typography.commentBook.font
        commentMyDisplayLabel.font = Typography.commentMy.font
    }
}
