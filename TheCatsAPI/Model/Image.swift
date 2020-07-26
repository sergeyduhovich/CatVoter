import Foundation

public struct Image: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int

    let breeds: [Breed]?
    let categories: [Category]?
}
