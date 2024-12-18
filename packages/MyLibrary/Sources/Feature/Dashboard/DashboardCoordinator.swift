//
//  DashboardCoordinator.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 18/12/2024.
//

import SwiftUI
import CommonInfrastructure

public protocol DashboardCoordinatorDelegate: AnyObject {
    func logout()
}

public final class DashboardCoordinator: ChildCoordinator {
    public var parentCoordinator: (any ParentCoordinator)?
    
    public var navigationController: UINavigationController
    weak var delegate: DashboardCoordinatorDelegate?
    
    public init(
        parentCoordinator: (any ParentCoordinator)?,
        navigationController: UINavigationController,
        delegate: DashboardCoordinatorDelegate? = nil
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    public func start() {
        let screen = DashboardScreen(homeScreenDelegate: self)
        navigationController.setViewControllers(
            [screen.viewController],
            animated: true
        )
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        didRemove viewController: UIViewController,
        animated: Bool
    ) {
        if viewController.isKind(of: UIHostingController<DashboardScreen>.self) {
            coordinatorDidFinish()
        }
    }
}

extension DashboardCoordinator: HomeScreenDelegate {
    func goToItemList() {
        let screen = ItemListScreen(goToItemDetails: goToItemDetails)
        navigationController.pushViewController(
            screen.viewController,
            animated: true
        )
    }
    
    func goToItemDetails() {
        let screen = ItemDetailsScreen()
        navigationController.pushViewController(
            screen.viewController,
            animated: true
        )
    }
    
    func logout() {
        delegate?.logout()
    }
}
