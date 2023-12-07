//
//  SceneDelegate.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("[SceneDelegate]:", #function)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground

//        let rootVC = SignInViewController()
//        rootVC.viewModelInjection(viewModel: SignInViewModel())
//        rootVC.viewInjection(sceneView: SignInView())
//        window?.rootViewController = UINavigationController(rootViewController: rootVC)
//        
//        let rootVC = UINavigationController(rootViewController: MyCustomTabBarController())
        let rootVC = MyCustomTabBarController()
//        rootVC.tabBar = CustomTabBar()
        window?.rootViewController = rootVC
        

//        let rootVC = BookshelfViewController()
//        rootVC.viewInjection(sceneView: BookshelfView())
//        rootVC.viewModelInjection(viewModel: BookshelfViewModel())
//        window?.rootViewController = UINavigationController(rootViewController: rootVC)
        
//        let rootVC = AddBookSearchViewController()
//        rootVC.viewInjection(sceneView: AddBookSearchView())
//        rootVC.viewModelInjection(viewModel: AddBookSearchViewModel())
//        window?.rootViewController = rootVC
        
//        let rootVC = AddBookViewController()
//        rootVC.viewInjection(sceneView: AddBookView())
//        rootVC.viewModelInjection(viewModel: AddBookViewModel())
//        window?.rootViewController = UINavigationController(rootViewController: rootVC)
        
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

extension SceneDelegate {
    // MARK: - RootViewChangeMethod
    
    func changeRootVC(viewController: UIViewController, animated: Bool) {
        guard let window = window else { return }
        window.rootViewController = viewController
        UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
}

