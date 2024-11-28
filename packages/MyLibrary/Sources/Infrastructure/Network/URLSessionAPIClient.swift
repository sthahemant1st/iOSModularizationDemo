//
//  URLSessionAPIClient.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 28/11/2024.
//

import Foundation

class URLSessionAPIClient: APIClient {
    
    // Perform a request and return a custom APIResponse object
    func request(
        baseURL: URL,
        path: String,
        method: HTTPMethod,
        body: Data? = nil,
        headers: [String: String]? = nil,
        queryParameters: [String: String]? = nil,
        contentType: ContentType
    ) async throws -> APIResponse {
        
        let (data, response) = try await performRequest(
            baseURL: baseURL,
            path: path,
            method: method,
            body: body,
            headers: headers,
            queryParameters: queryParameters,
            contentType: contentType
        )
        
        // Ensure the response is an HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        return APIResponse(data: data, response: httpResponse)
    }
    
    // Helper function to perform the actual network request
    private func performRequest(
        baseURL: URL,
        path: String,
        method: HTTPMethod,
        body: Data?,
        headers: [String: String]?,
        queryParameters: [String: String]?,
        contentType: ContentType
    ) async throws -> (Data, URLResponse) {
        
        let fullURL = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = method.rawValue
        
        // Set headers
        urlRequest.allHTTPHeaderFields = headers
        
        // Add query parameters if any
        if let queryParameters = queryParameters {
            var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)!
            components.queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            urlRequest.url = components.url
        }
        
        // Set the correct Content-Type and encode the body if needed
        switch contentType {
        case .json:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let body = body {
                urlRequest.httpBody = body
            }
        case .formURLEncoded:
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            if let body = body {
                urlRequest.httpBody = body
            }
        case .multipart:
            // Handle multipart if needed
            break
        case .plainText:
            urlRequest.setValue("text/plain", forHTTPHeaderField: "Content-Type")
            if let body = body {
                urlRequest.httpBody = body
            }
        }
        
        // Perform the network request
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        return (data, response)
    }
}
