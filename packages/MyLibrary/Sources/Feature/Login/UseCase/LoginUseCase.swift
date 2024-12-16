//
//  File.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 27/11/2024.
//

import Foundation

struct LoginUseCase: LoginUseCaseProtocol {
    func login(userName: String, password: String) async throws {
        if userName.isEmpty {
            throw LoginError.emptyUserName
        }
        if password.isEmpty {
            throw LoginError.emptyPassword
        }
        print("Login successful")
    }
}

enum LoginError: Error, LocalizedError {
    case emptyUserName
    case emptyPassword

    
    var errorDescription: String? {
        switch self {
        case .emptyUserName:
            return "User name cannot be empty"
        case .emptyPassword:
            return "Password cannot be empty"
        }
    }
}
