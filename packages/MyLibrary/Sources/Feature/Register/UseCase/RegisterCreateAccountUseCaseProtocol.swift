//
//  RegisterCreateAccountUseCaseProtocol.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//


import Foundation

protocol RegisterCreateAccountUseCaseProtocol: Sendable {
    func execute(
        username: String,
        password: String,
        token: String
    ) async throws
}

struct ResisterCreateAccountUseCase: RegisterCreateAccountUseCaseProtocol {
    func execute(username: String, password: String, token: String) async throws {
        if username.isEmpty {
            throw Error.emptyUsername
        }
        if password.isEmpty {
            throw Error.emptyPassword
        }
        print("Create account success")
    }
    
    enum Error: Swift.Error {
        case emptyUsername
        case emptyPassword
    }
}
