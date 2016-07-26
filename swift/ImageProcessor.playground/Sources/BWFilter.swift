import Foundation

public enum BWType {
    case Normal, Popular, Binary
}

public class BWFilter: Filter {
    var bwType: BWType
    
    let redCoefficient = 0.299
    let greenCoefficient = 0.587
    let blueCoefficient = 0.114
    
    public init(type: BWType) {
        self.bwType = type
    }
    
    public func apply(inout rgbaImage: RGBAImage) {
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = x + y * rgbaImage.width
                let pixel = rgbaImage.pixels[index]
                let grayColor = calculateGray(pixel)
                rgbaImage.pixels[index].blue = grayColor
                rgbaImage.pixels[index].green = grayColor
                rgbaImage.pixels[index].red = grayColor
            }
        }
    }
    
    private func calculateGray(pixel: Pixel) -> UInt8 {
        let blue = Double(pixel.blue)
        let red = Double(pixel.red)
        let green = Double(pixel.green)
        var grayValue: Double
        switch bwType {
        case .Normal:
            grayValue = redCoefficient * red + blueCoefficient * blue + greenCoefficient * green
        case .Popular:
            grayValue = sqrt(redCoefficient * red * red + blueCoefficient * blue * blue + greenCoefficient * green * green)
        case .Binary:
            let weightAverageColor = redCoefficient * red + blueCoefficient * blue + greenCoefficient * green
            grayValue = calculateBinaryColor(weightAverageColor)
        }
        return UInt8(grayValue)
    }
    
    private func calculateBinaryColor(averageColor: Double) -> Double {
        var grayValue: Double
        switch averageColor {
        case 0..<64:
            grayValue = 32
        case 64..<128:
            grayValue = 96
        case 128..<192:
            grayValue = 160
        case 192..<256:
            grayValue = 222
        default:
            grayValue = 0
        }
        return grayValue
    }
}
