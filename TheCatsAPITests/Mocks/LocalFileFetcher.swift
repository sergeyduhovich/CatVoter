import Foundation

class LocalFileFetcher {

    private let delay: DispatchTimeInterval
    private var breeds: [Breed] = []
    private var categories: [Category] = []
    private var images: [Image] = []

    init(delay: Double = 1.1) {
        self.delay = DispatchTimeInterval.milliseconds(Int(delay * 1000))

        do {
            breeds = try decode(from: "breeds.json")
        } catch {
            print(error)
        }

        do {
            categories = try decode(from: "categories.json")
        } catch {
            print(error)
        }

        do {
            images = try decode(from: "images.json")
        } catch {
            print(error)
        }
    }
}

extension LocalFileFetcher: FetcherProtocol {
    func breeds(completion: @escaping ([Breed]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion(self.breeds)
        }
    }

    func categories(completion: @escaping ([Category]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion(self.categories)
        }
    }

    func images(completion: @escaping ([Image]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion(self.images)
        }
    }
}

private extension LocalFileFetcher {
    enum LocalFileFetcherError: Error {
        case fileNotFound
    }

    func decode<T: Codable>(from file: String) throws -> T {
        guard let path = Bundle.main.path(forResource: file, ofType: nil) else {
            throw LocalFileFetcherError.fileNotFound
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(T.self, from: data)
    }
}
