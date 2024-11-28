//
//  File.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 27/11/2024.
//

import Foundation

protocol APIClient {
    func request(
        baseURL: URL,
        path: String,
        method: HTTPMethod,
        body: Data?,
        headers: [String: String]?,
        queryParameters: [String: String]?,
        contentType: ContentType
    ) async throws -> APIResponse
}
