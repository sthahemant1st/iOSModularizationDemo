//
//  ResisterCreateAccountUseCase.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 18/12/2024.
//


import Foundation

public struct ResisterCreateAccountUseCase: RegisterCreateAccountUseCaseProtocol {
    
    public init() {}
    
    public func execute(username: String, password: String, token: String) async throws {
        if username.isEmpty {
            throw Error.emptyUsername
        }
        if password.isEmpty {
            throw Error.emptyPassword
        }
        print("Create account success")
    }
    
    public enum Error: Swift.Error {
        case emptyUsername
        case emptyPassword
    }
}
