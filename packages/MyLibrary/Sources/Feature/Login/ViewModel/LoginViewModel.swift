//
//  File.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 27/11/2024.
//

import Foundation

@MainActor
class BaseViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    private(set) var error: Error?
    @Published var isErrorShown: Bool = false
    
    func showError(error: Error) {
        self.error = error
        isErrorShown = true
    }
    
    func dismissError() {
        error = nil
        isErrorShown = false
    }
}

@MainActor
final class LoginViewModel: BaseViewModel {
    private let loginUseCase: LoginUseCaseProtocol
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
        super.init()
    }
    
    func login() {
        Task {
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
            }
        }
    }
}

extension Task where Success == Never, Failure == Never {
    public static func sleep(seconds: Double) async throws {
        try await Task.sleep(nanoseconds: UInt64(seconds * Double(NSEC_PER_SEC)))
    }
}

