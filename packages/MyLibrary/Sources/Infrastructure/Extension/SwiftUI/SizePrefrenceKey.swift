import SwiftUI

// TODO: refactor - separate SizePreferenceKey & WidthPreferenceKey
//private struct SizePreferenceKey: PreferenceKey {
//    static var defaultValue: CGSize = .zero
//    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
//}
//
//public extension View {
//    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
//        background(
//            GeometryReader { geometryProxy in
//                Color.clear
//                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
//            }
//        )
//        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
//    }
//}
//
//private struct WidthPreferenceKey: PreferenceKey {
//    static var defaultValue: CGFloat = 0
//    
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}
//
//public extension View {
//    func readWidth(onChange: @escaping (CGFloat) -> Void) -> some View {
//        overlay {
//            GeometryReader { geometryProxy in
//                Color.clear
//                    .preference(key: WidthPreferenceKey.self, value: geometryProxy.frame(in: .local).width)
//            }
//        }
//        .onPreferenceChange( WidthPreferenceKey.self, perform: onChange)
//    }
//}
