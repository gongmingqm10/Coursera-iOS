import Foundation

class FilterFactory {
    internal class func createBWFilter() -> BWFilter {
        let filter = BWFilter()
        filter.intensity = 0.5
        return filter
    }
    
    internal class func createLayerFilter() -> LayerFilter {
        let filter = LayerFilter()
        filter.intensity = 0.5
        return filter
    }
}