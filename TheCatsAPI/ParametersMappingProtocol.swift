import Foundation

// sourcery: AutoMockable
public protocol ParametersMappingProtocol {
    var queryItems: Array<URLQueryItem>? { get }
    var body: Data? { get }
}

extension ParametersMappingProtocol where Self: Encodable {
    public var body: Data? {
        return try? JSONEncoder().encode(self)
    }

    public var queryItems: Array<URLQueryItem>? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }

        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }

        return dict.enumerated()
            .compactMap { item -> URLQueryItem? in
                guard let value = item.element.value as? CustomStringConvertible else {
                    return nil
                }
                return URLQueryItem(name: item.element.key, value: value.description) }
    }
}
