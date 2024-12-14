//
//  ParentCoordinator.swift
//  ProjectSoul
//
//  Created by Hemant Shrestha on 17/06/2024.
//

import Foundation

/// All the top-level coordinators should conform to this protocol
@MainActor 
public protocol ParentCoordinator: Coordinator {
    /// Each Coordinator can have its own children coordinators
    var childCoordinators: [ChildCoordinator] { get set }
    /**
     Adds the given coordinator to the list of children.
     - Parameters:
     - child: A coordinator.
     */
    func addChild(_ child: ChildCoordinator?)
    /**
     Tells the parent coordinator that given coordinator is done and should be removed from the list of children.
     - Parameters:
     - child: A coordinator.
     */
    func childDidFinish(_ child: ChildCoordinator?)
}

public extension ParentCoordinator {
    // MARK: - Coordinator Functions
    /**
     Appends the coordinator to the children array.
     - Parameters:
     - child: The child coordinator to be appended to the list.
     */
    func addChild(_ child: ChildCoordinator?) {
        if let child {
            childCoordinators.append(child)
        }
    }
    
    /**
     Removes the child from children array.
     - Parameters:
     - child: The child coordinator to be removed from the list.
     */
    func childDidFinish(_ child: ChildCoordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
}
