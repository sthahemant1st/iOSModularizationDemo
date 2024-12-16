//
//  BaseView.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//


import SwiftUI

public extension View {
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
