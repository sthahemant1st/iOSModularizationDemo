//
//  RegisterScreen.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//

import SwiftUI
import CommonInfrastructure

struct RegisterScreen: View {
    @StateObject var viewModel: RegisterViewModel
    private let registerSuccess: () -> Void
    
    init(
        viewModel: RegisterViewModel,
        registerSuccess: @escaping () -> Void
    ) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.registerSuccess = registerSuccess
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text("Create Account")
                    .font(.title)
                Text("Fill with a unique username and strong password")
                    .foregroundColor(AppColor.secondaryText)
            }
            .padding(.bottom, 16)
            
            VStack(spacing: 16) {
                AppTextField(
                    label: "Username",
                    text: $viewModel.username
                )
                AppTextField(
                    label: "New Password",
                    text: $viewModel.newPassword
                )
                AppTextField(
                    label: "Confirm Password",
                    text: $viewModel.confirmPassword
                )
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            PrimaryButton(
                label: "Create Account",
                action: createAccountTapped
            )
        }
        .padding()
        .baseView(viewModel: viewModel)
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func createAccountTapped() {
        Task {
            do {
                try await viewModel.createAccount()
                registerSuccess()
            } catch {
            }
        }
    }
}

#Preview {
    RegisterScreen(
        viewModel: .init(token: ""),
        registerSuccess: {}
    )
}
