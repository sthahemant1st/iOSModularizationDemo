//
//  RegisterVerifyEmailUseCaseProtocol.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//


import Foundation

public protocol RegisterVerifyEmailUseCaseProtocol: Sendable {
    func execute(verificationCode: String, token: String) async throws -> String
}
