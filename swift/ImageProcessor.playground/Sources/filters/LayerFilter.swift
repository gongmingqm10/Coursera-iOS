import Foundation

public class LayerFilter: Filter {
    
    override public func apply(inout rgbaImage: RGBAImage) {
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = x + y * rgbaImage.width
                let pixel = rgbaImage.pixels[index]
                rgbaImage.pixels[index].blue = getLayerValue(pixel.blue)
                rgbaImage.pixels[index].green = getLayerValue(pixel.green)
                rgbaImage.pixels[index].red = getLayerValue(pixel.red)
            }
        }
    }
    
    private func getLayerValue(pixelColor: UInt8) -> UInt8 {
        //TODO: should use the intensity to design how many layers to distribute
        var layerValue: Double
        switch Int(pixelColor) {
        case 0..<64:
            layerValue = 32
        case 64..<128:
            layerValue = 96
        case 128..<192:
            layerValue = 160
        case 192..<256:
            layerValue = 222
        default:
            layerValue = 0
        }
        layerValue += 64 * intensity!
        return UInt8(min(255, max(0, layerValue)))
    }
}