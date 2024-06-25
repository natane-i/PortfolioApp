//
//  UnsplashAPI.swift
//  PortfolioApp
//
//  Created by spark-01 on 2024/06/25.
//

import Foundation

class UnsplashAPI {
    private let accessKey = "ES6CV5zqrpnRs1O_dPaGjbijJGt8De_CBV7ne0cr-ME"
    
    func fetchUnsplashAPI(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/photos/?per_page=5&order_by=latest&client_id=\(accessKey)") else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let result = try JSONDecoder().decode([PhotoData].self, from: data)
                let images = result.map { $0.urls.regular }
                completion(images)
            } catch {
                print("Error in decoding: \(error.localizedDescription)")
                print("Raw data: \(String(data: data, encoding: .utf8) ?? "")")
                completion([])
            }
        }.resume()
    }
}

