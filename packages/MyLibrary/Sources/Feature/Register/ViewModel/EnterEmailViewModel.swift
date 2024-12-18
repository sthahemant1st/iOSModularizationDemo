//
//  EnterEmailViewModel.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//

import Foundation
import CommonInfrastructure
import UseCase

@MainActor
final class EnterEmailViewModel: BaseViewModel {
    let registerEnterEmailUseCase: RegisterEnterEmailUseCaseProtocol
    @Published var email: String = ""
    
    init(
        registerEnterEmailUseCase: RegisterEnterEmailUseCaseProtocol = RegisterEnterEmailUseCase()
    ) {
        self.registerEnterEmailUseCase = registerEnterEmailUseCase
    }
    func continueTapped() async throws -> String {
        isLoading = true
        defer { isLoading = false }
        do {
            let token = try await registerEnterEmailUseCase.execute(email: email)
            return token
        } catch {
            showError(error: error)
            throw error
        }
    }
}
