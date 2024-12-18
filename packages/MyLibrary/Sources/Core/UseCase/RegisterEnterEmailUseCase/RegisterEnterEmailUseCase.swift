//
//  RegisterEnterEmailUseCase.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 18/12/2024.
//


import Foundation

public struct RegisterEnterEmailUseCase: RegisterEnterEmailUseCaseProtocol {
    
    public init() {}
    
    public func execute(email: String) async throws -> String {
        if email.isEmpty {
            throw Error.emptyEmail
        }
        return "Token for email verify"
    }
    
    public enum Error: Swift.Error {
        case emptyEmail
    }
}
