//
//  SceneDelegate.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 24.11.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createMainVC()
        window?.makeKeyAndVisible()
        
        func createMainVC() -> UINavigationController {
            let container = DependencyContainer()
            let mainVC = container.makePokemonListViewController()
            mainVC.title = "OkePoke"
            let nc = UINavigationController(rootViewController: mainVC)
            nc.navigationBar.prefersLargeTitles = true
            return nc
        }
    }


}

