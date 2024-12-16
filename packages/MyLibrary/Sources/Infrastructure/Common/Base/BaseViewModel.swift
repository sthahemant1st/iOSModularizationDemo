//
//  BaseViewModel.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//

import Foundation

@MainActor
open class BaseViewModel: ObservableObject {
    @Published public var isLoading: Bool = false
    public private(set) var error: Error?
    @Published public var isErrorShown: Bool = false
    
    public init() {}
    
    public func showError(error: Error) {
        self.error = error
        isErrorShown = true
    }
    
    public func dismissError() {
        error = nil
        isErrorShown = false
    }
}
