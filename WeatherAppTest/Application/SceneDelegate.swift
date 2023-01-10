//
//  SceneDelegate.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 19.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        UIBarButtonItem.appearance().tintColor = .white
        
        let rootVC = MainViewController()
        window?.rootViewController = UINavigationController(rootViewController: rootVC)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .dark
    }
}
