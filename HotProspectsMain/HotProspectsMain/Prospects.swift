//
//  Prospects.swift
//  HotProspectsMain
//
//  Created by Sparsh Paliwal on 12/7/23.
//

import SwiftUI


class Prospect: Identifiable, Codable, Comparable {
    var id: UUID = UUID()
    var name: String = "Anonymous"
    var email: String = ""
    /// We don't want anyone outside of this file to change this. We are only letting Prospects class change this.
    fileprivate(set) var isContacted = false
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        return lhs.name > rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        return lhs.id == rhs.id
    }
}

@MainActor class Prospects: ObservableObject {
    /// We have made it private to set this variable. You can only get it.
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        
        people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func add(prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        /// This is used to manually send updates to views subscribed.
        /// If we would have directly tried to toggle prospect in view it would not happen because Prospect is a class.
        /// We tell before hand it's about to change ,and when toggle happens, an update is sent to views.
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
