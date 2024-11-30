//
//  URLSessionProtocol.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 30/11/2024.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    
}
