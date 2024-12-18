//
//  File.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 27/11/2024.
//

import Foundation

public struct LoginUseCase: LoginUseCaseProtocol {
    
    public init() {}
    
    public func login(
        userName: String,
        password: String
    ) async throws {
        if userName.isEmpty {
            throw Error.emptyUserName
        }
        if password.isEmpty {
            throw Error.emptyPassword
        }
        print("Login successful")
    }
    
    public enum Error: Swift.Error, LocalizedError {
        case emptyUserName
        case emptyPassword

        public var errorDescription: String? {
            switch self {
            case .emptyUserName:
                return "User name cannot be empty"
            case .emptyPassword:
                return "Password cannot be empty"
            }
        }
    }
}
