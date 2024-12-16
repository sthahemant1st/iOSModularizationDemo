//
//  AppTextField.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//

import SwiftUI

public struct AppTextField: View {
    private let label: String
    private let placeholder: String?
    private let isSecure: Bool
    @Binding private var text: String
    
    public init(
        label: String,
        placeholder: String? = nil,
        isSecure: Bool = false,
        text: Binding<String>
    ) {
        self.label = label
        self.placeholder = placeholder
        self.isSecure = isSecure
        self._text = text
    }
    
    public var body: some View {
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
