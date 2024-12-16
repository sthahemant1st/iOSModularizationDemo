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
    
    init(
        viewModel: LoginViewModel,
        forgotPasswordTapped: @escaping () -> Void,
        registerTapped: @escaping () -> Void
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.forgotPasswordTapped = forgotPasswordTapped
        self.registerTapped = registerTapped
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
                    action: viewModel.login
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
}

#Preview {
    NavigationView {
        LoginScreen(
            viewModel: .init(),
            forgotPasswordTapped: {},
            registerTapped: {}
        )
    }
}

extension View {
    func baseView(viewModel: BaseViewModel) -> some View {
        BaseView(viewModel: viewModel, content: { self })
    }
}

struct BaseView<Content: View>: View {
    @ObservedObject var viewModel: BaseViewModel
    let content: () -> Content
    init(
        viewModel: BaseViewModel,
        content: @escaping () -> Content
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.content = content
    }
    
    var body: some View {
        ZStack {
            content()
                .alert(
                    "Error",
                    isPresented: $viewModel.isErrorShown,
                    presenting: viewModel.error,
                    actions: { error in
                        Button("OK", action: {
                            viewModel.dismissError()
                        })
                    },
                    message: { error in
                        Text(error.localizedDescription)
                    }
                )
            
            if viewModel.isLoading {
                Color
                    .black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .overlay {
                        ProgressView()
                    }
            }
        }
    }
}

struct AppTextField: View {
    let label: String
    var placeholder: String?
    var isSecure: Bool = false
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.callout)
            Group {
                if isSecure {
                    SecureField(
                        placeholder ?? label,
                        text: $text
                    )
                } else {
                    TextField(
                        placeholder ?? label,
                        text: $text
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(minHeight: 48)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, style: .init(lineWidth: 1))
            }
        }
    }
}
