//
//  CustomButtonStyle.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 30/11/2024.
//

import SwiftUI

struct AppButtonStyle: ButtonStyle {
    var font: Font = .title
    var padding: EdgeInsets = EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
    var maxWidth: CGFloat?
    var minHeight: CGFloat?
    var backgroundColor: Color = AppColor.button
    var foregroundColor: Color = .white
    var cornerRadius: CGFloat = 10
    var shadowColor: Color = .gray
    var shadowRadius: CGFloat = 5
    var shadowOffset: CGSize = CGSize(width: 0, height: 4)
    var scaleOnPress: CGFloat = 0.94
    var opacityOnPress: Double = 0.6
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(font)
            .padding(padding)
            .frame(maxWidth: maxWidth, minHeight: minHeight)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowOffset.width, y: shadowOffset.height)
            .scaleEffect(configuration.isPressed ? scaleOnPress : 1.0)
            .opacity(configuration.isPressed ? opacityOnPress : 1.0)
            .animation(.interactiveSpring, value: configuration.isPressed)
    }
}

struct AppButton: View {
    typealias Action = () -> Void
    let label: String
    let action: Action
    
    var body: some View {
        Button(label, action: action)
            .buttonStyle(AppButtonStyle())
    }
}

#Preview {
    VStack {
        Button(
            action: {
            },
            label: {
                HStack {
                    Text("Hemant")
                    AppImage.hemant
                        .frame(width: 50, height: 50)
                        .clipped()
                }
            }
        )
        .buttonStyle(AppButtonStyle())
        
        Button(
            "Shrestha",
            role: .cancel,
            action: {}
        )
        .buttonStyle(AppButtonStyle())
        
        AppButton(label: "Wow", action: {})
    }
}
