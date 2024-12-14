//
//  UserDefaultsService.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 14/12/2024.
//

import Foundation

public class UserDefaultsService: UserDefaultsServiceProtocol {
    private let defaults = UserDefaults.standard
    
    public init() {}
    
    public func save<T: Codable>(value: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(value) {
            defaults.set(encoded, forKey: key)
        }
    }

    public func fetch<T: Codable>(forKey key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    public func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
