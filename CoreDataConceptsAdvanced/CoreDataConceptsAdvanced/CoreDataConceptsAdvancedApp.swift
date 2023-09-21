//
//  CoreDataConceptsAdvancedApp.swift
//  CoreDataConceptsAdvanced
//
//  Created by Sparsh Paliwal on 9/20/23.
//

import SwiftUI

@main
struct CoreDataConceptsAdvancedApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
