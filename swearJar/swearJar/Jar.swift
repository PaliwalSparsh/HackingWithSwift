//
//  Jar.swift
//  swearJar
//
//  Created by Sparsh Paliwal on 7/11/23.
//

import Foundation

struct Jar: Codable {
    var items: [JarItem] = [] {
        didSet {
            if let encodedData = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encodedData, forKey: "Jar")
            }
        }
    }
    
    var totalAmount: Double {
        items.reduce(0, { $0 + $1.amount })
    }
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: "Jar") {
            if let decodedData = try? JSONDecoder().decode([JarItem].self, from: savedData) {
                items = decodedData
                return
            }
        }
        return
    }
}
