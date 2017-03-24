import Foundation
import UIKit

class Board {
    let name: String
    let id: String
    let imageUrl: URL
    let description: String
    var image: UIImage? = nil
    
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
    
    func getImage(onImageFetched: @escaping (UIImage) -> Void) {
        if let image = self.image {
            onImageFetched(image)
            return
        } else {
            DispatchQueue.global(qos: .default).async {
                if let data = try? Data(contentsOf: self.imageUrl) {
                    if let image = UIImage(data: data) {
                        self.image = image
                        onImageFetched(image)
                    }
                }
            }
        }
    }
}
