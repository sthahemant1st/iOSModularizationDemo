//
//  EnterEmailScreen.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//

import SwiftUI
import CommonInfrastructure

struct EnterEmailScreen: View {
    @StateObject var viewModel: EnterEmailViewModel
    private let continueSuccess: (String) -> Void
    
    init(
        viewModel: EnterEmailViewModel,
        continueSuccess: @escaping (String) -> Void
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.continueSuccess = continueSuccess
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text("Enter your email")
                    .font(.title)
                Text("An OTP will be sent to your email")
                    .foregroundColor(AppColor.secondaryText)
            }
            .padding(.bottom, 16)
            
            AppTextField(
                label: "Email",
                text: $viewModel.email
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
            let token = try? await viewModel.continueTapped()
            guard let token else { return }
            continueSuccess(token)
        }
    }
}

#Preview {
    NavigationView {
        EnterEmailScreen(
            viewModel: .init(),
            continueSuccess: { _ in }
        )
    }
}
