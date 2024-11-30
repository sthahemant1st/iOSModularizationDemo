//
//  APIEndPoint.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 29/11/2024.
//

import Foundation

enum HttpScheme: String {
    case https
    case http
}

struct APIEndpoint {
    var scheme: HttpScheme
    var host: String
    let path: String
    var method: HTTPMethod
    var body: (Encodable & Sendable)?
    var headers: [String: String]?
    var queryItems: [URLQueryItem]?
    var contentType: ContentType
}
