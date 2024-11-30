//
//  View+Extension.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 30/11/2024.
//


import SwiftUI

extension View {
    func withBorder(
        borderColor: Color = .gray,
        borderWidth: CGFloat = 2,
        cornerRadius: CGFloat = 10
    ) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
}

#Preview {
    VStack {
        AppImage.hemant
            .resizable()
            .frame(width: 200, height:200)
            .withBorder()
    }
}
