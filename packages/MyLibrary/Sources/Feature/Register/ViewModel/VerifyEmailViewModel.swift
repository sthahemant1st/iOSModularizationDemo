//
//  VerifyEmailViewModel.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//


import SwiftUI
import CommonInfrastructure

@MainActor
final class VerifyEmailViewModel: BaseViewModel {
    private let registerVerifyEmailUseCase: RegisterVerifyEmailUseCaseProtocol
    private let token: String
    @Published var verificationCode: String = ""
    
    init(
        registerVerifyEmailUseCase: RegisterVerifyEmailUseCaseProtocol = RegisterVerifyEmailUseCase(),
        token: String
    ) {
        self.registerVerifyEmailUseCase = registerVerifyEmailUseCase
        self.token = token
        super.init()
    }
    
    func verifyEmail() async throws -> String {
        isLoading = true
        defer { isLoading = false }
        do {
            return try await registerVerifyEmailUseCase.execute(verificationCode: verificationCode, token: token)
        } catch {
            showError(error: error)
            throw error
        }
    }
}
