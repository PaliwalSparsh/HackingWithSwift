//
//  Mission.swift
//  moonshot
//
//  Created by Sparsh Paliwal on 7/15/23.
//

import Foundation

/// You can define a struct inside a struct, CrewRole is meant to be used inside Mission anyway so, we can define it Inside Mission itself. If in future we want to use this Type we can just instantiate by using Mission.CrewRole()
struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
}
