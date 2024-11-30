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
        do {
            _ = try await sut.request(endpoint: testEndpoint)
        } catch {}
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
