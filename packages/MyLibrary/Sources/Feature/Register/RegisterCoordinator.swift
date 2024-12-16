//
//  RegisterCoordinator.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//

import SwiftUI
import CommonInfrastructure

public class RegisterCoordinator: ChildCoordinator {
    public var parentCoordinator: (any ParentCoordinator)?
    
    public var navigationController: UINavigationController
    
    public init(
        parentCoordinator: (any ParentCoordinator)?,
        navigationController: UINavigationController
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewModel = EnterEmailViewModel()
        let screen = EnterEmailScreen(
            viewModel: viewModel,
            continueSuccess: { [weak self] token in
                self?.navigateToVerifyEmail(token: token)
            }
        )
        navigationController.pushViewController(
            screen.viewController,
            animated: true
        )
    }
    
    private func navigateToVerifyEmail(token: String) {
        let viewModel = VerifyEmailViewModel(token: token)
        let screen = VerifyEmailScreen(
            viewModel: viewModel,
            continueSuccess: {[weak self] token in
                self?.navigateToRegister(token: token)
            }
        )
        navigationController.pushViewController(screen.viewController, animated: true)
    }
    
    private func navigateToRegister(token: String) {
        let viewModel = RegisterViewModel(token: token)
        let screen = RegisterScreen(
            viewModel: viewModel,
            registerSuccess: { [weak self] in
                guard let self else { return }
                var viewControllers = navigationController.viewControllers
                viewControllers.removeLast(2)
                navigationController.setViewControllers(viewControllers, animated: true)
            }
        )
        var viewControllers = navigationController.viewControllers
        viewControllers.removeLast()
        viewControllers.append(screen.viewController)
        navigationController.setViewControllers(viewControllers, animated: true)
        
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        didRemove viewController: UIViewController,
        animated: Bool
    ) {
        if viewController.isKind(of: UIHostingController<EnterEmailScreen>.self) {
            coordinatorDidFinish()
        }
    }
    
}
