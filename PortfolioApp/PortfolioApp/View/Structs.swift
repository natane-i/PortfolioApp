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
    let alternative_slugs: Slugs
    let updated_at: Date
    let user: User
    let urls: URLs
}

struct Slugs: Codable {
    let ja: String
}

struct User: Codable {
    let username: String
    let name: String
    let location: String?
    let links: Links
}


struct Links: Codable {
    let html: String
}

struct URLs: Codable {
    let regular: String
}

enum ColorTags: String, CaseIterable {
    case red = "red"
    case blue = "blue"
    case green = "green"
    case yellow = "yellow"
    case white = "white"
    case black = "black"
}
