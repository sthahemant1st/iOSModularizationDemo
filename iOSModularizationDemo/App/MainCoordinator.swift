//
//  MainCoordinator.swift
//  iOSModularizationDemo
//
//  Created by Hemant Shrestha on 14/12/2024.
//


import UIKit
import CommonInfrastructure
import Login

class MainCoordinator: ParentCoordinator {
    var childCoordinators: [any ChildCoordinator]
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        let loginCoordinator = LoginCoordinator(
            parentCoordinator: self,
            navigationController: navigationController,
            delegate: self
        )
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
}

extension MainCoordinator: LoginCoordinatorDelegate {
    func navigateToForgotPassword() {
        
    }
    
    func navigateToRegister() {
        
    }
}
