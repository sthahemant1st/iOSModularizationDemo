//
//  MainCoordinator.swift
//  iOSModularizationDemo
//
//  Created by Hemant Shrestha on 14/12/2024.
//


import UIKit
import Coordinator

class MainCoordinator: ParentCoordinator {
    var childCoordinators: [any ChildCoordinator]
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .cyan
        navigationController.viewControllers = [viewController]
    }
}