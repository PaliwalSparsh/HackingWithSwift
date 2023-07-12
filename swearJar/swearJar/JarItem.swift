//
//  JarItem.swift
//  swearJar
//
//  Created by Sparsh Paliwal on 7/11/23.
//

import Foundation

struct JarItem: Identifiable {
    let id = UUID()
    let amount: Double
    let date: Date
}
