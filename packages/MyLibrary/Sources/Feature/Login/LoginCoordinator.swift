//
//  LoginCoordinator.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 15/12/2024.
//

import CommonInfrastructure
import SwiftUI

public protocol LoginCoordinatorDelegate: AnyObject {
    func navigateToForgotPassword()
    func navigateToRegister()
    func loginSuccess()
}

public class LoginCoordinator: ChildCoordinator {
    public var parentCoordinator: (any ParentCoordinator)?
    public var navigationController: UINavigationController
    private weak var delegate: LoginCoordinatorDelegate?
    
    public init(
        parentCoordinator: (any ParentCoordinator)?,
        navigationController: UINavigationController,
        delegate: LoginCoordinatorDelegate?
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    public func start() {
        let viewModel = LoginViewModel()
        let loginScreen = LoginScreen(
            viewModel: viewModel,
            forgotPasswordTapped: { [weak self] in
                self?.delegate?.navigateToForgotPassword()
            },
            registerTapped: { [weak self] in
                self?.delegate?.navigateToRegister()
            },
            loginSuccess: { [weak self] in
                self?.delegate?.loginSuccess()
            }
        )
        
        navigationController.setViewControllers(
            [loginScreen.viewController],
            animated: true
        )
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        didRemove viewController: UIViewController,
        animated: Bool
    ) {
        if viewController
            .isKind(of: UIHostingController<LoginScreen>.self) {
            coordinatorDidFinish()
        }
    }
}
