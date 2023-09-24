//
//  Friend.swift
//  ChallengeSixty
//
//  Created by Sparsh Paliwal on 9/24/23.
//

import Foundation

class Friend: Codable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
