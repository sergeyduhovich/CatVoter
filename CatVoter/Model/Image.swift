import Foundation

struct Image: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int

    let breeds: [Breed]?
    let categories: [Category]?
}
