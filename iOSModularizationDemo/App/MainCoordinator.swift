//
//  MainCoordinator.swift
//  iOSModularizationDemo
//
//  Created by Hemant Shrestha on 14/12/2024.
//

import UIKit
import CommonInfrastructure
import Login
import Register
import Dashboard

class MainCoordinator: NSObject, ParentCoordinator {
    var childCoordinators: [any ChildCoordinator]
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
        super.init()
        self.navigationController.delegate = self
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
    func loginSuccess() {
        let dashboardCoordinator = DashboardCoordinator(
            parentCoordinator: self,
            navigationController: navigationController,
            delegate: self
        )
        childCoordinators.append(dashboardCoordinator)
        dashboardCoordinator.start()
    }
    
    func navigateToForgotPassword() {
        navigationController.showAlert(withMessage: "Not implemented")
    }
    
    func navigateToRegister() {
        let registerCoordinator = RegisterCoordinator(
            parentCoordinator: self,
            navigationController: navigationController
        )
        childCoordinators.append(registerCoordinator)
        registerCoordinator.start()
    }
}

extension MainCoordinator: DashboardCoordinatorDelegate {
    func logout() {
        start()
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        for coordinator in self.childCoordinators {
            coordinator.navigationController(navigationController, didRemove: fromViewController, animated: animated)
        }
    }
}
