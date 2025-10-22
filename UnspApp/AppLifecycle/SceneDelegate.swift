//
//  SceneDelegate.swift
//  FeatureTemplate
//
//  Created by Malik Timurkaev on 26.09.2025.
//

import UIKit
import CoreKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: Coordinator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let navigation = UINavigationController()
        let window = UIWindow(windowScene: windowScene)
        
        let coordinator = AppCoordinator(
            navigation: navigation,
            window: window
        )
        
        self.appCoordinator = coordinator
        self.window = window
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        coordinator.start()
    }
}
