import Foundation

public struct Breed: Codable {
    let id: String
    let name: String
    let description: String
    let wikipediaUrl: String?
    let lifeSpan: String
    let hypoallergenic: Int 
    let origin: String
    let temperament: String
}
