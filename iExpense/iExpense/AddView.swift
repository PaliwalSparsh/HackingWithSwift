//
//  AddView.swift
//  iExpense
//
//  Created by Sparsh Paliwal on 7/11/23.
//

import SwiftUI

struct AddView: View {
    
    /// Dismiss in the environment of the view is linked to the bool which decides when to show this sheet, which we set in the parent view of this sheet.

    @Environment(\.dismiss) var dismiss
    /// So, what we’re going to do is add a property to AddView to store an Expenses object. It won’t create the object there, which means we need to use @ObservedObject rather than @StateObject.
    @ObservedObject var expenses: Expenses
    @State var name: String = ""
    @State var type: String = "Business"
    @State var amount: Double = 0.0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Expense Type", selection: $type) {
                    ForEach(["Business", "Personal"], id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    expenses.items.append(Expense(name: name, type: type, amount: amount))
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
