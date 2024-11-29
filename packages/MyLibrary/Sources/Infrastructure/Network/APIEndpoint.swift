//
//  APIEndPoint.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 29/11/2024.
//

import Foundation

struct APIEndpoint {
    let baseURL: URL
    let path: String
    let method: HTTPMethod
    let body: Data?
    let headers: [String: String]?
    let queryParameters: [String: String]?
    let contentType: ContentType
}
