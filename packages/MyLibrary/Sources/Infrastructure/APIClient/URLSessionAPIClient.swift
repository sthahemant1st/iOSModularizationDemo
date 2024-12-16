//
//  URLSessionAPIClient.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 28/11/2024.
//

import Foundation

class URLSessionAPIClient: APIClient {
    
    private var session: URLSessionProtocol
    private let jsonEncoder: JSONEncoder
    init(
        session: URLSessionProtocol = URLSession.shared,
        jsonEncoder: JSONEncoder = .init()
    ) {
        self.session = session
        self.jsonEncoder = jsonEncoder
    }
    
    func request(endpoint: APIEndpoint) async throws -> APIResponse {
        let (data, response) = try await performRequest(endpoint: endpoint)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        return APIResponse(data: data, response: httpResponse)
    }
    
    // Helper function to perform the actual network request
    private func performRequest(endpoint: APIEndpoint) async throws -> (Data, URLResponse) {
        var component = URLComponents()
        component.scheme = endpoint.scheme.rawValue
        component.host = endpoint.host
        component.path = endpoint.path
        if let queryItems  = endpoint.queryItems {
            component.queryItems = queryItems
        }

        var urlRequest = URLRequest(url: component.url!)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        // Set headers
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        switch endpoint.contentType {
        case .json:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .formURLEncoded:
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        case .multipart:
            urlRequest.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
            throw Error.multipartContentTypeNotSupported
        case .plainText:
            urlRequest.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        }
        
        if let body = endpoint.body {
            urlRequest.httpBody = try jsonEncoder.encode(body)
        }
        
        // Perform the network request
        let (data, response) = try await session.data(for: urlRequest)
        return (data, response)
    }
    
    enum Error: Swift.Error {
        case multipartContentTypeNotSupported
    }
}


