//
//  Structs.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/25.
//

import Foundation

struct Photos: Codable {
    let results: [PhotoData]
}

struct PhotoData: Codable {
    let id: String
    let urls: URLs
}

struct URLs: Codable {
    let regular: String
}

enum ColorTags: String, CaseIterable {
    case red = "red"
    case blue = "blue"
    case green = "green"
    case yellow = "yellow"
    case black = "black"
    case white = "white"
}
