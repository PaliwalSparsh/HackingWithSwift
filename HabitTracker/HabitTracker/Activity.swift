//
//  Activity.swift
//  HabitTracker
//
//  Created by Sparsh Paliwal on 8/22/23.
//

import Foundation

class Activity: Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
    var streak: Double
    
    init(name: String) {
        self.name = name
        self.streak = 0
    }
    
    func incrementStreak() {
        streak = streak + 1
    }
}
