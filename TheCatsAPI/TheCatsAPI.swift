import Foundation

public class TheCatsAPI {

    let apiKey: String
    let session = URLSession.shared
    let apiHost = "api.thecatapi.com"
    let apiVersion = "v1"

    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    func send<Request: RequestProtocol>(request: Request, completion: @escaping Request.Completion) {
        
        guard let url = url(for: request) else {
            completion(.failure(.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        urlRequest.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        urlRequest.httpMethod = request.httpMethod
        urlRequest.httpBody = request.parameters.body

        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            completion(self.process(data: data, response: response, error: error))
        }

        task.resume()
    }
}

private extension TheCatsAPI {
    func url<Request: RequestProtocol>(for request: Request) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = apiHost
        components.path = "/" + apiVersion + "/" + request.path
        components.queryItems = request.parameters.queryItems
        return components.url
    }

    func process<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<T, TheCatsError> {
        guard error == nil else {
            return .failure(.network(error!))
        }

        let acceptableStatusCodes = 200..<300
        if let httpResponse = response as? HTTPURLResponse,
            !acceptableStatusCodes.contains(httpResponse.statusCode) {
            return .failure(.failed(statusCode: httpResponse.statusCode))
        }

        guard let data = data else {
            return .failure(.decodingFailed(nil))
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let result = try decoder.decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(.decodingFailed(error))
        }
    }
}
