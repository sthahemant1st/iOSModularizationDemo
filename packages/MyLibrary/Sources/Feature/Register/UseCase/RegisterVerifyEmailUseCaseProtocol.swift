//
//  RegisterVerifyEmailUseCaseProtocol.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//


import Foundation

protocol RegisterVerifyEmailUseCaseProtocol: Sendable {
    func execute(verificationCode: String, token: String) async throws -> String
}

struct RegisterVerifyEmailUseCase: RegisterVerifyEmailUseCaseProtocol {
    func execute(verificationCode: String, token: String) async throws -> String {
        if verificationCode.isEmpty {
            throw Error.emptyVerificationCode
        }
        return "token for registration"
    }
    
    enum Error: Swift.Error {
        case emptyVerificationCode
    }
}
