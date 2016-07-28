import UIKit

public class ImageFilters {
    let originalImage: RGBAImage
    
    public init(image: UIImage) {
        self.originalImage = RGBAImage(image: image)!
    }
    
    func apply(intensity: Double, filters: [Filter]) -> UIImage {
        var filterImage = originalImage
        for filter in filters {
            filter.intensity = intensity
            filter.apply(&filterImage)
        }
        return filterImage.toUIImage()!
    }

}