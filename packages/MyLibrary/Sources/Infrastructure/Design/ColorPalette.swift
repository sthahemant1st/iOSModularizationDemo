//
//  ColorPalette.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 29/11/2024.
//

import SwiftUI

private struct ColorPalette: View {

    
    var body: some View {
        ScrollView {
            VStack {
                itemView(name: "accent", color: AppColor.accent)
                itemView(name: "border", color: AppColor.border)
                itemView(name: "button", color: AppColor.button)
                itemView(name: "background", color: AppColor.background)
                itemView(name: "error", color: AppColor.error)
                itemView(name: "primary", color: AppColor.primary)
                itemView(name: "secondary", color: AppColor.secondary)
                itemView(name: "text", color: AppColor.text)
            }
            .padding()
        }
        .navigationTitle("Color Palette")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    fileprivate func itemView(
        name: String,
        color: Color
    ) -> some View {
        return HStack {
            Text("\(name):")
                .frame(width: 100, alignment: .leading)
            Rectangle()
                .frame(height: 50)
                .foregroundColor(color)
                .border(.gray, width: 3)
        }
    }
}

#Preview("Light Mode") {
    NavigationView {
        ColorPalette()
            .preferredColorScheme(.light)
    }
}

#Preview("Dark Mode") {
    NavigationView {
        ColorPalette()
            .preferredColorScheme(.dark)
    }
}
