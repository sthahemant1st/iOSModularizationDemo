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

public extension View {
    var viewController: UIHostingController<Self> {
        UIHostingController(rootView: self)
    }
}

public extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    // https://stackoverflow.com/questions/68892142/swiftui-using-view-modifiers-between-different-ios-versions-without-available
    @ViewBuilder
    func modify<Content: View>(@ViewBuilder _ transform: (Self) -> Content?) -> some View {
        if let view = transform(self), !(view is EmptyView) {
            view
        } else {
            self
        }
    }
    func scrollBounceBasedOnSize() -> some View {
        self.modify { view in
            if #available(iOS 16.6, *) {
                view.scrollBounceBehavior(.basedOnSize)
            }
        }
    }
    func appNavigationBarHidden(_ hidden: Bool) -> some View {
        self.modify { view in
            if #available(iOS 16, *) {
                if hidden {
                    view
                        .toolbar(.hidden, for: .navigationBar)
                } else {
                    view.toolbar(.visible, for: .navigationBar)
                }
            } else {
                view
                    .navigationBarHidden(hidden)
            }
        }
    }
    
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
#if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    func tvOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(tvOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    func watchOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(watchOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

public extension View {
    func filter(value: Binding<String>, _ isIncluded: @escaping (Character) -> Bool) -> some View {
        self.onChange(of: value.wrappedValue) { new in
            value.wrappedValue = new.filter({ isIncluded($0) })
        }
    }
}

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func borderDashed(
        cornerWidth: CGFloat = 8,
        cornerHeight: CGFloat = 8,
        lineWidth: CGFloat = 1,
        dashLength: CGFloat = 4,
        foregroundColor: Color
    ) -> some View {
        self.background(
            RoundedRectangle(cornerSize: CGSize(width: cornerWidth, height: cornerHeight))
                .strokeBorder(style: StrokeStyle(lineWidth: lineWidth, dash: [dashLength]))
                .foregroundColor(foregroundColor)
        )
    }
}

public struct RoundedCorner: Shape {
    private let radius: CGFloat
    private let corners: UIRectCorner

    public init(
        radius: CGFloat = .infinity,
        corners: UIRectCorner = .allCorners
    ) {
        self.radius = radius
        self.corners = corners
    }
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
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

