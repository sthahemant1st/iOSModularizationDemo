//
//  DefaultPersistenceManager.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 14/12/2024.
//

import Foundation
import UserDefaultsService
import Model

final class DefaultPersistenceManager: PersistenceManager {
    private let userDefaultsService: UserDefaultsServiceProtocol
    
    init(userDefaultsService: UserDefaultsServiceProtocol) {
        self.userDefaultsService = userDefaultsService
    }

    var loggedInUser: Profile? {
        get {
            userDefaultsService.fetch(forKey: Key.loggedInUser)
        }
        set {
            userDefaultsService.save(value: newValue, forKey: Key.loggedInUser)
        }
    }

    func logout() {
        loggedInUser = nil
        // Additional logout logic if necessary
    }
    
    enum Key {
        static let loggedInUser = "loggedInUser"
    }
}
