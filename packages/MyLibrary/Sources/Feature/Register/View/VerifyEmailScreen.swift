//
//  VerifyEmailScreen.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//

import SwiftUI
import CommonInfrastructure

struct VerifyEmailScreen: View {
    @StateObject var viewModel: VerifyEmailViewModel
    private let continueSuccess: (String) -> Void
    
    init(
        viewModel: VerifyEmailViewModel,
        continueSuccess: @escaping (String) -> Void
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.continueSuccess = continueSuccess
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text("Enter code your email")
                    .font(.title)
                Text("An verification code is sent to your email")
                    .foregroundColor(AppColor.secondaryText)
            }
            .padding(.bottom, 16)
            
            AppTextField(
                label: "Verification Code",
                text: $viewModel.verificationCode
            )
            .frame(maxHeight: .infinity, alignment: .top)
            
            PrimaryButton(
                label: "Continue",
                action: continueTapped
            )
        }
        .padding()
        .baseView(viewModel: viewModel)
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func continueTapped() {
        Task {
            let token = try? await viewModel.verifyEmail()
            guard let token else { return }
            continueSuccess(token)
        }
    }
}

#Preview {
    VerifyEmailScreen(
        viewModel: .init(token: ""),
        continueSuccess: { _ in }
    )
}
