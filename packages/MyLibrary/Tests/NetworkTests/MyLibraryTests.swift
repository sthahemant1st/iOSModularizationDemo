import Testing
import Foundation
@testable import Network

struct URLSessionAPIClientTests {
    private let mockURLSession: MockURLSession
    private let sut: URLSessionAPIClient
    
    init() async throws {
        mockURLSession = MockURLSession()
        sut = URLSessionAPIClient(session: mockURLSession)
    }
    
    
    struct ContentTypeCheck {
        let type: ContentType
        let value: String
    }
    @Test(
        "check if content type is set correctly",
        arguments: [
            ContentTypeCheck(type: ContentType.json, value: "application/json"),
            ContentTypeCheck(type: ContentType.formURLEncoded, value: "application/x-www-form-urlencoded"),
            ContentTypeCheck(type: ContentType.plainText, value: "text/plain")
        ]
    )
    func contentTypeCheck(contentTypeCheck: ContentTypeCheck) async throws {
        let testEndpoint = APIEndpoint(
            scheme: .https,
            host: "test.com",
            path: "/test",
            method: .get,
            body: nil,
            headers: nil,
            queryItems: nil,
            contentType: contentTypeCheck.type
        )
        mockSuccess()
        _ = try await sut.request(endpoint: testEndpoint)
        #expect(mockURLSession.capturedRequest?.value(forHTTPHeaderField: "Content-Type")  == contentTypeCheck.value)
    }
    
    @Test("should throw APIError.invalidResponse when response is not HttpURLResponse")
    func checkURLResponse() async throws {
        let testEndpoint = APIEndpoint(
            scheme: .https,
            host: "test.com",
            path: "/test",
            method: .get,
            body: nil,
            headers: nil,
            queryItems: nil,
            contentType: .json
        )
        let error: APIError = .invalidResponse
        mockURLSession.response = URLResponse(url: URL(string: "https://test.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        mockURLSession.data = "".data(using: .utf8)
        await #expect(throws: error) {
            try await sut.request(endpoint: testEndpoint)
        }
    }
    
    @Test(
        "check if httpMethod is set correctly",
        arguments: [
            HTTPMethod.get,
            HTTPMethod.post,
            HTTPMethod.put,
            HTTPMethod.delete
        ]
    )
    func checkHTTPMethod(httpMethod: HTTPMethod) async throws {
        let testEndpoint = APIEndpoint(
            scheme: .https,
            host: "test.com",
            path: "/test",
            method: httpMethod,
            body: nil,
            headers: nil,
            queryItems: nil,
            contentType: .json
        )
        mockSuccess()
        _ = try await sut.request(endpoint: testEndpoint)
        #expect(mockURLSession.capturedRequest?.httpMethod == httpMethod.rawValue)
    }
    @Test(
        "check if http scheme is set correctly",
        arguments: [
            HttpScheme.http,
            HttpScheme.https
        ]
    )
    func checkHttpScheme(scheme: HttpScheme) async throws {
        let testEndpoint = APIEndpoint(
            scheme: scheme,
            host: "test.com",
            path: "/test",
            method: .get,
            body: nil,
            headers: nil,
            queryItems: nil,
            contentType: .json
        )
        mockSuccess()
        _ = try await sut.request(endpoint: testEndpoint)
        #expect(mockURLSession.capturedRequest?.url?.scheme == scheme.rawValue)
    }
    
    @Test(
        "check if query items are set correctly",
        arguments: [
            [
                URLQueryItem(name: "key", value: "value"),
                URLQueryItem(name: "key4", value: "value4")
            ],
            [],
            [
                URLQueryItem(name: "key5", value: "value5"),
                URLQueryItem(name: "key4", value: "value4"),
            ],
            [
                URLQueryItem(name: "key5", value: "value5"),
                URLQueryItem(name: "key4", value: nil),
            ]
        ]
    )
    func chekcQueryItems(queryItems: [URLQueryItem]) async throws {
        let testEndpoint = APIEndpoint(
            scheme: .http,
            host: "test.com",
            path: "/test",
            method: .get,
            body: nil,
            headers: nil,
            queryItems: queryItems,
            contentType: .json
        )
        mockSuccess()
        _ = try await sut.request(endpoint: testEndpoint)
        let capturedQuery = mockURLSession.capturedRequest?.url?.query
        let expectedQuery = queryItems
            .map { "\($0.name)\($0.value == nil ? "" : "=\($0.value!)")"}
            .joined(separator: "&")
        #expect( capturedQuery == expectedQuery)
    }
    
    func mockSuccess() {
        mockURLSession.response = HTTPURLResponse()
        mockURLSession.data = "".data(using: .utf8)
    }
}

class MockURLSession: URLSessionProtocol {
    var capturedRequest: URLRequest?
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        capturedRequest = request
        if let error = error {
            throw error
        }
        guard let data = data, let response = response else {
            throw NSError(domain: "MockError", code: 1, userInfo: nil)
        }
        return (data, response)
    }
}
