//
//  Bundle-Decodable.swift
//  moonshot
//
//  Created by Sparsh Paliwal on 7/15/23.
//

import Foundation


extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to load URL")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load URL")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to load URL")
        }
        
        return loaded
    }
}
