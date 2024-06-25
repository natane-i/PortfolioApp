//
//  Structs.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/25.
//

import Foundation

struct PhotoData: Codable {
    let id: String
    let urls: URLs
}

struct URLs: Codable {
    let regular: String
}
