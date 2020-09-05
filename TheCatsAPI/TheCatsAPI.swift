import Foundation

public class TheCatsAPI {

    private let session = URLSession.shared
    private let apiKey: String
    private let baseURL: String
    private let urlBuilder: URLBuilderProtocol

    public init(apiKey: String,
                baseURL: String = "https://api.thecatapi.com/v1",
                urlBuilder: URLBuilderProtocol = URLBuilder()) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.urlBuilder = urlBuilder
    }

    func send<Request: RequestProtocol>(request: Request, completion: @escaping Request.Completion) {
        guard var urlRequest = urlBuilder.urlRequest(for: request, baseURL: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }

        urlRequest.addValue(apiKey, forHTTPHeaderField: "x-api-key")

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
            return .failure(.noDataInResponse)
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
