//
//  File.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 27/11/2024.
//

import Foundation
import CommonInfrastructure
import UseCase

@MainActor
final class LoginViewModel: BaseViewModel {
    private let loginUseCase: LoginUseCaseProtocol
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
        super.init()
    }
    
    func login() async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            try await Task.sleep(seconds: 1)
            try await loginUseCase.login(
                userName: username,
                password: password
            )
        } catch {
            showError(error: error)
            throw error
        }
    }
}

extension Task where Success == Never, Failure == Never {
    public static func sleep(seconds: Double) async throws {
        try await Task.sleep(nanoseconds: UInt64(seconds * Double(NSEC_PER_SEC)))
    }
}
