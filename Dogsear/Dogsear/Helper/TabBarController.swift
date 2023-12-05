//
//  TabBarController.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/5/23.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        self.selectedIndex = 0
    }
}

private extension TabBarController {
    func setUp() {
        let rootVC = BookshelfViewController()
        rootVC.viewInjection(sceneView: BookshelfView())
        rootVC.viewModelInjection(viewModel: BookshelfViewModel())
        let bookShelfVC = UINavigationController(rootViewController: rootVC)
        bookShelfVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet")
        )


        viewControllers = [bookShelfVC]
        tabBar.tintColor = .systemPink
        tabBar.barTintColor = .secondarySystemBackground // 탭바 배경색 설정
        tabBar.shadowImage = UIImage() // 탭바 경계선 없애기
        tabBar.backgroundImage = UIImage() // 탭바 경계선 없애기
    }
}

