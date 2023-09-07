//
//  bookwormApp.swift
//  bookworm
//
//  Created by Sparsh Paliwal on 9/1/23.
//

import SwiftUI

@main
struct bookwormApp: App {
    // We created dataController as an Observable object so we can use StateObject once when app starts to initialise it.
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        // swiftui environment has an existing managedObjectContext, there we add the viewContext from dataController
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
