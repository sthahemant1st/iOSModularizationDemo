//
//  RegisterCreateAccountUseCaseProtocol.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//


import Foundation

public protocol RegisterCreateAccountUseCaseProtocol: Sendable {
    func execute(
        username: String,
        password: String,
        token: String
    ) async throws
}
