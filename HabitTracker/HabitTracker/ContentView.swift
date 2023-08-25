//
//  ContentView.swift
//  HabitTracker
//
//  Created by Sparsh Paliwal on 8/22/23.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var activities: Activities
    @State var habitName = ""
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Habit Name")
                        TextField("Habit Name", text: $habitName)
                    }
                }
            }
            Spacer()
            Button("Add Habit") {
                activities.items.append(Activity(name: habitName))
                dismiss()
            }.buttonStyle(.borderedProminent)
        }
    }
}

struct ContentView: View {
    @StateObject var activities = Activities()
    @State var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(activities.items) { activity in
                    NavigationLink(destination: EditActivityView(activities: activities, id: activity.id)) {
                        Text(activity.name)
                            .badge(Int(activity.streak))
                    }
                }
            }
            .toolbar {
                Button("Add") {
                    showSheet = true
                }
            }
            .sheet(isPresented: $showSheet) {
                AddHabitView(activities: activities)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
