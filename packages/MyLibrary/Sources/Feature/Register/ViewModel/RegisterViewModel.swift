//
//  RegisterViewModel.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//

import SwiftUI
import CommonInfrastructure
import UseCase

final class RegisterViewModel: BaseViewModel {
    private let useCase: RegisterCreateAccountUseCaseProtocol
    private let token: String
    @Published var username: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    
    init(
        useCase: RegisterCreateAccountUseCaseProtocol = ResisterCreateAccountUseCase(),
        token: String
    ) {
        self.useCase = useCase
        self.token = token
    }
    
    func createAccount() async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            try await useCase.execute(
                username: username,
                password: newPassword,
                token: token
            )
        } catch {
            showError(error: error)
            throw error
        }
    }
}
