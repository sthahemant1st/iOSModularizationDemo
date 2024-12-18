//
//  LoginUseCaseProtocol.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//


import Foundation

public protocol LoginUseCaseProtocol: Sendable {
    func login(userName: String, password: String) async throws
}
