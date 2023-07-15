//
//  Bundle-Decodable.swift
//  moonshot
//
//  Created by Sparsh Paliwal on 7/15/23.
//

import Foundation


extension Bundle {
    /// T here is a generic, T: Codable tells that whatever generic is incoming should conform to the Codable protocol. We define that we are going to be using generic in <> brackets. The name of generic need not be T, it can be anything Fish, Plant etc.
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to load URL")
        }
        
        /// Here insted of String contentsOf we are using Data contentsOf
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load URL")
        }
        
        let decoder = JSONDecoder()
        
        /// We can tell decoder that the content you are about to decode might contain some dates(in the following format, here y-MM-dd), when you encounter them convert them into Date Type instead of converting them into just strings.
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to load URL")
        }
        
        return loaded
    }
}
