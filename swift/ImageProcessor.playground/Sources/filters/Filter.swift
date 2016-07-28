import Foundation

public class Filter {
    public var intensity: Double? {
        didSet {
            intensity = intensity! - 0.5
        }
    }
    func apply(inout rgbaImage: RGBAImage) {
    }
}
