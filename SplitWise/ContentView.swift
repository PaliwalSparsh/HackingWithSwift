//
//  ContentView.swift
//  SplitWise
//
//  Created by Sparsh Paliwal on 6/15/23.
//

import SwiftUI

// 1. All of these View struct are called by SwiftUI as a constant. Thus, these are immutable structs, all @State properties are stored seperately in some other place in swift, where they are tracked for change and based on a update a new struct is created.
struct ContentView: View {
    @State private var amount: Double = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    // @FocusState is same as state just designed specifically for focus states in swift.
    @FocusState private var isAmountFocused: Bool
    
    private var amountPerPerson: Double {
        amount * (1 + Double(tipPercentage)/100) / Double(numberOfPeople + 2)
    }
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    // The format parameter in Text and Textfield is amazing, as it does so much heavy lifting for us.
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $amount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($isAmountFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip Amount", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tip would you like to give ?")
                }
                Section {
                    Text(amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit") // The reason title comes here is Nav view can have multiple views inside it so the title will belong to one of the views inside it.
            .toolbar { // modifier lets us specify toolbar items for a view. These toolbar items might appear in various places on the screen – in the navigation bar at the top, in a special toolbar area at the bottom, and so on.
                ToolbarItemGroup(placement: .keyboard) { // lets us place one or more buttons in a specific location, and this is where we get to specify we want a keyboard toolbar – a toolbar that is attached to the keyboard, so it will automatically appear and disappear with the keyboard.
                    Spacer()
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
