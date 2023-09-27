//
//  ChallengeSixtyApp.swift
//  ChallengeSixty
//
//  Created by Sparsh Paliwal on 9/24/23.
//

import SwiftUI

@main
struct ChallengeSixtyApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
