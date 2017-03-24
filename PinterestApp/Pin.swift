import Foundation
import UIKit

class Pin {
    let note: String
    let id: String
    let imageUrl: URL
    private(set) var image: UIImage? = nil
    
    init?(dictionary: [String: Any]) {
        guard let note = dictionary["note"] as? String,
            let id = dictionary["id"] as? String,
            let imageDictionary = dictionary["image"] as? [String: Any],
            let imageDictionaryComponent = imageDictionary["original"] as? [String: Any],
            let imageUrlString = imageDictionaryComponent["url"] as? String,
            let imageUrl = URL(string: imageUrlString)
            else { return nil }
        
        self.note = note
        self.id = id
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
