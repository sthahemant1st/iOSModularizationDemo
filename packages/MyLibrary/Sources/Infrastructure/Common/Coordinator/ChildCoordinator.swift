//
//  ChildCoordinator.swift
//  ProjectSoul
//
//  Created by Hemant Shrestha on 17/06/2024.
//

import UIKit

/// All Child coordinators should conform to this protocol
@MainActor
public protocol ChildCoordinator: Coordinator {
    /// Don't forget to make parentCoordinator weak in ChildCoordinator's implementation
    var parentCoordinator: ParentCoordinator? { get set }
    /**
     The body of this function should call `childDidFinish(_ child:)` on the parent coordinator to remove the child from parent's `childCoordinators`.
     */
    func coordinatorDidFinish()
    
    func navigationController(
        _ navigationController: UINavigationController,
        didRemove viewController: UIViewController,
        animated: Bool
    )
}

public extension ChildCoordinator {
    func coordinatorDidFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
