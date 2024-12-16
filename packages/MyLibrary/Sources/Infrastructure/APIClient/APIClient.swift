//
//  File.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 27/11/2024.
//

import Foundation

protocol APIClient {
    func request(endpoint: APIEndpoint) async throws -> APIResponse
}
