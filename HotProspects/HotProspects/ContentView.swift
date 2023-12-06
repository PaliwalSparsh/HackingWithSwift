//
//  ContentView.swift
//  HotProspects
//
//  Created by Sparsh Paliwal on 12/5/23.
//

import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            /// Manually publishing changes to views.
            /// This is an alternative way of publihsing information apart from using @Published.
            /// Instead of using Published and having willSet to ourselves we can use this area for doing logging or maybe invoking other functions.
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
    @StateObject private var updater = DelayedUpdater()
    @State private var selectedTab = "One"
    @State private var output = ""
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                List {
                    Text("Taylor Swift")
                        .swipeActions {
                            Button(role: .destructive) {
                                print("Deleting")
                            } label: {
                                Label("Delete", systemImage: "minus.circle")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                print("Pinning")
                            } label: {
                                Label("Pin", systemImage: "pin")
                            }
                            .tint(.orange)
                        }
                }
                Spacer()
                Text("Click to see context menu")
                    .padding()
                    .contextMenu {
                        Button("Option 1") {}
                        Button("Option 2") {}
                        Button("Option 3", role: .destructive) {}
                    }
                Spacer()
                
                Text(output)

                Text(updater.value, format: .number)
                Spacer()
                Text("Programatically go to Tab 2")
                    .onTapGesture {
                        selectedTab = "Two"
                    }
                Spacer()
            }
            .tabItem {
                Label("One", systemImage: "star")
            }.tag("One")
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }.tag("Two")
        }.task {
            await fetchReading()
        }
    }
    
    func fetchReading() async {
        /// We can put create a Task closure, and it provides us a lot more flexibility later, such as ability to cancel task on demand.
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings."
        }
        
        /// It provides us with a result property which has Result datatype. This datatype has two values .Success and .Failure
        let result = await fetchTask.result
        
        /// We can use success and failure in the following way.
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Download error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
