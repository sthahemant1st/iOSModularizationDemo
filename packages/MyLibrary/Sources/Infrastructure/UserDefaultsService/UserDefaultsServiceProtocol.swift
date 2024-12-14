//
//  UserDefaultsServiceProtocol.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 14/12/2024.
//


import Foundation

public protocol UserDefaultsServiceProtocol: Sendable {
    func save<T: Codable>(value: T, forKey key: String)
    func fetch<T: Codable>(forKey key: String) -> T?
    func removeValue(forKey key: String)
}

extension UserDefaultsServiceProtocol {
    public func save<T: Codable>(value: T?, forKey key: String) {
        if let value {
            save(value: value, forKey: key)
        } else {
            removeValue(forKey: key)
        }
    }
}
