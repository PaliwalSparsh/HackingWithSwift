//
//  Jar.swift
//  swearJar
//
//  Created by Sparsh Paliwal on 7/11/23.
//

import Foundation

class Jar: ObservableObject {
    @Published var items: [JarItem] = []
    var totalAmount: Double {
        items.reduce(0, { $0 + $1.amount })
    }
}


