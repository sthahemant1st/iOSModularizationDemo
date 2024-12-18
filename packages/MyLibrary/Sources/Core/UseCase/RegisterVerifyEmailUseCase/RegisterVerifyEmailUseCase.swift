//
//  RegisterVerifyEmailUseCase.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 18/12/2024.
//


import Foundation

public struct RegisterVerifyEmailUseCase: RegisterVerifyEmailUseCaseProtocol {
    
    public init() {}
    
    public func execute(verificationCode: String, token: String) async throws -> String {
        if verificationCode.isEmpty {
            throw Error.emptyVerificationCode
        }
        return "token for registration"
    }
    
    public enum Error: Swift.Error {
        case emptyVerificationCode
    }
}
