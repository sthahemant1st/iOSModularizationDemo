import SwiftUI

public struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    private let action: (() -> Void)?
    
    public init(
        action: (() -> Void)?
    ) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

public extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}
