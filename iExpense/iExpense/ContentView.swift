//
//  ContentView.swift
//  iExpense
//
//  Created by Sparsh Paliwal on 7/11/23.
//

import SwiftUI

struct ContentView: View {
    // @StateObject is a property wrapper used to instantiate Observeable Object. When you are using class you cannot use @State because @State doesn't do a deep check on if all values of a class have changed. Thus, it works well for structs and primary datatypes such as numebrs and strings. Because they are recreated on reassignment.
    // Thus for classes we need to first create them as ObservableObject and inside them we need to define properties that should be looked for change using @Published wrapper.
    // So to sum it up, using @StateObject here asks SwiftUI to watch the object for any change announcements, so any time one of our @Published properties changes the view will refresh its body. It’s only used when creating a class instance – all other times you ‘ll use @ObservedObject instead.
    @StateObject var expenses = Expenses()
    @State var showAddSheet = false
    
    var body: some View {
        NavigationView {
            List {
                /// Swift provides us a convinient delete function. However it come swith its own quirks. Delete function only works when you have a ForEach inside the list and you apply .onDelete modifier to that forEach.
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.subheadline.bold())
                            Text(item.type)
                        }
                        Spacer()
                        Text("\(item.amount.formatted())")
                    }
                    
                }.onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            // This is how easily we can add sheets to a view :)
            .sheet(isPresented: $showAddSheet) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
