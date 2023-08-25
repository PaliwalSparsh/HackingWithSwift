//
//  Activities.swift
//  HabitTracker
//
//  Created by Sparsh Paliwal on 8/22/23.
//

import Foundation

class Activities: ObservableObject {
    @Published var items = [Activity]()
    {
        didSet {
            if let encodedItems = try? JSONEncoder().encode(items) {
                // Save to user defaults
                UserDefaults.standard.setValue(encodedItems, forKey: "items")
            }
        }
    }

    init(items: [Activity] = [Activity]()) {
        if let encodedItems = UserDefaults.standard.data(forKey: "items") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: encodedItems) {
                self.items = decodedItems
                return
            }
        }
        self.items = items
    }
}
