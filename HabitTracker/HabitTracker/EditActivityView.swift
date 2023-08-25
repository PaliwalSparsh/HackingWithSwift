//
//  EditActivity.swift
//  HabitTracker
//
//  Created by Sparsh Paliwal on 8/22/23.
//

import SwiftUI

struct EditActivityView: View {
    @ObservedObject var activities: Activities
    var id: UUID
    
    var activityIndex: Int {
        activities.items.firstIndex(where: {$0.id == id}) ?? 0
    }

    var body: some View {
        return VStack {
            Text(activities.items[activityIndex].streak, format: .number)
                .font(.largeTitle.bold())
            Stepper(value: $activities.items[activityIndex].streak, in: 0...100, format: .number) {
                Text("Inrement/Decrement")
            }
        }.navigationTitle(activities.items[activityIndex].name)
    }
}

struct EditActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let activities = Activities(items: [Activity(name: "Gym")])
        return EditActivityView(activities: activities, id: activities.items[0].id)
    }
}
