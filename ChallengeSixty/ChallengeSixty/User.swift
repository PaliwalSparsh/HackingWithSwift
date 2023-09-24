//
//  User.swift
//  ChallengeSixty
//
//  Created by Sparsh Paliwal on 9/24/23.
//

import Foundation

class MasterModel: ObservableObject {
    @Published var users: [User]

    init() {        
        self.users = []
    }
}

class User: Codable {
    let id: String
    var isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    init(id: String, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [Friend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
}
