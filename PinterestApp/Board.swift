import Foundation

struct Board {
    let name: String
    let id: String
    let imageUrl: URL
    let description: String
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let id = dictionary["id"] as? String,
            let imageDictionary = dictionary["image"] as? [String: Any],
            let imageDictionaryComponent = imageDictionary["60x60"] as? [String: Any],
            let imageUrlString = imageDictionaryComponent["url"] as? String,
            let imageUrl = URL(string: imageUrlString),
            let description = dictionary["description"] as? String
            else { return nil }
        
        self.name = name
        self.id = id
        self.description = description
        self.imageUrl = imageUrl
    }
}
