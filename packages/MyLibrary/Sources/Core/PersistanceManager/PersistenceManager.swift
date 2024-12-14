//
//  PersistenceManager.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 14/12/2024.
//

import Foundation
import Model

protocol PersistenceManager: Sendable {
    var loggedInUser: Profile? { get set }
    func logout()
}
