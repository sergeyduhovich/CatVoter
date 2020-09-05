import Foundation

public protocol URLBuilderProtocol {
    func urlRequest<Request: RequestProtocol>(for request: Request, baseURL: String) -> URLRequest?
}

public class URLBuilder: URLBuilderProtocol {
    public init() {}
    public func urlRequest<Request: RequestProtocol>(for request: Request, baseURL: String) -> URLRequest? {

        guard baseURL.isSeemToBeURLString, !request.path.isEmpty else {
            return nil
        }

        let base = baseURL.removeSlashesAtTheEnd()
        let path = request.path
            .removeSlashesAtTheEnd()
            .removeSlashesAtTheBeginning()

        let urlString = base + "/" + path

        guard let url = URL(string: urlString),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }

        if request.parameters.queryItems?.isEmpty == false,
            request.httpMethod == "GET" {
            components.queryItems = request.parameters.queryItems
        }

        guard let componentsURL = components.url else {
            return nil
        }

        var result = URLRequest(url: componentsURL)
        result.httpMethod = request.httpMethod
        if request.httpMethod != "GET" {
            result.httpBody = request.parameters.body
        }
        return result
    }
}

private extension String {
    func removeSlashesAtTheEnd() -> String {
        var result = self
        while result.hasSuffix("/") {
            result = String(result.dropLast())
        }
        return result
    }

    func removeSlashesAtTheBeginning() -> String {
        var result = self
        while result.starts(with: "/") {
            result = String(result.dropFirst())
        }
        return result
    }

    var isSeemToBeURLString: Bool {
        guard !self.isEmpty else {
            return false
        }

        let types: NSTextCheckingResult.CheckingType = [.link]
        guard let detector = try? NSDataDetector(types: types.rawValue) else {
            return false
        }

        return detector.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange.init(location: 0, length: self.count)) > 0
    }
}
