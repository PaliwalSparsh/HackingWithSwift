//
//  DataController.swift
//  bookworm
//
//  Created by Sparsh Paliwal on 9/7/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    // Here we tell Core Data to use Bookworm model, but we don't load it yet.
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        // We load the datamodel using loadPersistentStores
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load")
            }
        }
    }
}
