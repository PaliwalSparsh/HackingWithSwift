//
//  Challenge77App.swift
//  Challenge77
//
//  Created by Sparsh Paliwal on 12/6/23.
//

import SwiftUI

@main
struct Challenge77App: App {
    @StateObject var friends = Friends()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(friends)
        }
    }
}
