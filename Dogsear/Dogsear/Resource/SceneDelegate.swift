//
//  SceneDelegate.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/23/23.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("[SceneDelegate]:", #function)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground

        let userDefaultsManager = UserDefaultsManager()
        
        if userDefaultsManager.getIsAutoLogin() {
            if Auth.auth().currentUser != nil {
                let rootVC = MyCustomTabBarController()
                window?.rootViewController = rootVC
                window?.makeKeyAndVisible()
                return
            }
        }
        let rootVC = SignInViewController(sceneView: SignInView(), viewModel: SignInViewModel())
        window?.rootViewController = UINavigationController(rootViewController: rootVC)
        
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

