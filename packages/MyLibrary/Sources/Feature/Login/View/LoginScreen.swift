//
//  LoginScreen.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 27/11/2024.
//

import SwiftUI
import CommonInfrastructure

struct LoginScreen: View {
    @StateObject private var viewModel: LoginViewModel
    private let forgotPasswordTapped: () -> Void
    private let registerTapped: () -> Void
    private let loginSuccess: () -> Void
    
    init(
        viewModel: LoginViewModel,
        forgotPasswordTapped: @escaping () -> Void,
        registerTapped: @escaping () -> Void,
        loginSuccess: @escaping () -> Void
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.forgotPasswordTapped = forgotPasswordTapped
        self.registerTapped = registerTapped
        self.loginSuccess = loginSuccess
    }
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                AppTextField(
                    label: "Username",
                    text: $viewModel.username
                )
                AppTextField(
                    label: "Password",
                    isSecure: true,
                    text: $viewModel.password
                )
                Button(action: forgotPasswordTapped) {
                    Text("Forgot Password?")
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                PrimaryButton(
                    label: "Login",
                    action: loginTapped
                )
            }
            .frame(maxHeight: .infinity)
            
            HStack {
                Text("Haven't registered yet?")
                    .font(.callout)
                    .foregroundColor(AppColor.secondaryText)
                Button(action: registerTapped) {
                    Text("Register")
                        .font(.callout)
                }
            }
        }
        .padding()
        .baseView(viewModel: viewModel)
        .navigationBarTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func loginTapped() {
        Task {
            do {
                try await viewModel.login()
                loginSuccess()
            } catch {
                
            }
        }
    }
}

#Preview {
    NavigationView {
        LoginScreen(
            viewModel: .init(),
            forgotPasswordTapped: {},
            registerTapped: {},
            loginSuccess: {}
        )
    }
}
