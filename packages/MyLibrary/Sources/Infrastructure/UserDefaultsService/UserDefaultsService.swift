//
//  UserDefaultsService.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 14/12/2024.
//

import Foundation

public final class UserDefaultsService: UserDefaultsServiceProtocol {

    public init() {}
    
    public func save<T: Codable>(value: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    public func fetch<T: Codable>(forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    public func removeValue(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
