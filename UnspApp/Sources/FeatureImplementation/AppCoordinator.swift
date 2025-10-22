//
//  AppCoordinator.swift
//  UnspApp
//
//  Created by Malik Timurkaev on 23.10.2025.
//

import UIKit
import CoreKit
import Foundation
import UnspAuthorization
import UnspMainFlow

@MainActor
final class AppCoordinator: CompositionCoordinator {
    
    var children: [Coordinator] = []
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    private let navigation: UINavigationController
    private let window: UIWindow
    
    init(
        navigation: UINavigationController,
        window: UIWindow
    ) {
        self.navigation = navigation
        self.window = window
    }
    
    func start() {
        showAuthorizationFlow()
    }
    
    func didFinishChild(_ coordinator: any Coordinator) {
        removeChild(coordinator)
        
        if coordinator is RootUnspAuthCoordinator {
            showMainFlow()
        } else {
            showAuthorizationFlow()
        }
    }
}

private extension AppCoordinator {
    func showMainFlow() {
        let child = RootUnspMainFlowCoordinator(window: window)
        addChild(child)
        child.start()
    }
    
    func showAuthorizationFlow() {
        let child = RootUnspAuthCoordinator(navigation: navigation)
        addChild(child)
        child.start()
    }
}
