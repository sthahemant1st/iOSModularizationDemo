//
//  RegisterEnterEmailUseCaseProtocol.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//


import Foundation

public protocol RegisterEnterEmailUseCaseProtocol: Sendable {
    func execute(email: String) async throws -> String
}
