import Foundation

public extension Encodable {
    /// Converting object to post-able JSON
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let dictionary = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return dictionary
    }
    
    func toData(_ encoder: JSONEncoder = JSONEncoder()) throws -> Data? {
        return try?  encoder.encode(self)
    }
}
