//
//  RegisterEnterEmailUseCaseProtocol.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//


import Foundation

protocol RegisterEnterEmailUseCaseProtocol: Sendable {
    func execute(email: String) async throws -> String
}

struct RegisterEnterEmailUseCase: RegisterEnterEmailUseCaseProtocol {
    func execute(email: String) async throws -> String {
        if email.isEmpty {
            throw Error.emptyEmail
        }
        return "Token for email verify"
    }
    
    enum Error: Swift.Error {
        case emptyEmail
    }
}
