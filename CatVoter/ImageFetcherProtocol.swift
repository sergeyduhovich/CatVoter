import Foundation

protocol FetcherProtocol {
    func breeds(completion: @escaping ([Breed]) -> Void)
    func categories(completion: @escaping ([Category]) -> Void)
    func images(completion: @escaping ([Image]) -> Void)
}
