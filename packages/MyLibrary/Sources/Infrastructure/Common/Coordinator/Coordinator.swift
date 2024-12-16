//
//  File.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 27/11/2024.
//

import UIKit

@MainActor
public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}
