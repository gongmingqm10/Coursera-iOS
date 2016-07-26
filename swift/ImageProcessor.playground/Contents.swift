//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "London")!

let imageFilters = ImageFilters(image: image)

let bwNormalImage = imageFilters.apply(BWFilter(type: BWType.Normal))

let bwPopularImage = imageFilters.apply(BWFilter(type: BWType.Popular))

let bwBinaryImage = imageFilters.apply(BWFilter(type: BWType.Binary))

	

