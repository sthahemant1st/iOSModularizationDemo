//
//  CustomButtonStyle.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 30/11/2024.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    var font: Font
    var padding: EdgeInsets
    var maxWidth: CGFloat?
    var minHeight: CGFloat?
    var backgroundColor: Color
    var foregroundColor: Color
    var cornerRadius: CGFloat
    var shadowColor: Color
    var shadowRadius: CGFloat
    var shadowOffset: CGSize
    var scaleOnPress: CGFloat
    var opacityOnPress: Double
    
    public init(
        font: Font = .title3,
        padding: EdgeInsets = EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16),
        maxWidth: CGFloat? = .infinity,
        minHeight: CGFloat? = 48,
        backgroundColor: Color = AppColor.button,
        foregroundColor: Color = .white,
        cornerRadius: CGFloat = 24,
        shadowColor: Color = .gray,
        shadowRadius: CGFloat = 4,
        shadowOffset: CGSize = CGSize(width: 0, height: 0),
        scaleOnPress: CGFloat = 0.99,
        opacityOnPress: Double = 0.9
    ) {
        self.font = font
        self.padding = padding
        self.maxWidth = maxWidth
        self.minHeight = minHeight
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.scaleOnPress = scaleOnPress
        self.opacityOnPress = opacityOnPress
    }
    
    public func makeBody(configuration: Configuration) -> some View {
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

public struct PrimaryButton: View {
    public typealias Action = () -> Void
    let label: String
    let action: Action
    let primeyButtonStyle: PrimaryButtonStyle
    
    public init(
        label: String,
        primaryButtonStyle: PrimaryButtonStyle = .init(),
        action: @escaping Action
    ) {
        self.label = label
        self.primeyButtonStyle = primaryButtonStyle
        self.action = action
    }
    
    public var body: some View {
        Button(label, action: action)
            .buttonStyle(primeyButtonStyle)
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
        .buttonStyle(PrimaryButtonStyle())
        
        Button(
            "Shrestha",
            role: .cancel,
            action: {}
        )
        .buttonStyle(PrimaryButtonStyle())
        
        PrimaryButton(label: "Wow", action: {})
    }
}
