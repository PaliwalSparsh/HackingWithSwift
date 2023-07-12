//
//  Expenses.swift
//  iExpense
//
//  Created by Sparsh Paliwal on 7/11/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [Expense]() {
        didSet {
            if let encodedItems = try? JSONEncoder().encode(items) {
                /// UserDefaults allows us to save stuff to iPhone storage, there is also an wrapper for UserDefaults i.e. @AppStorage however currently it supports only basic types such as text, numbers and bools. So for complex types we need to use 
                UserDefaults.standard.set(encodedItems, forKey: "Items")
            }
        }
    }
    
    var firstBusinessTypeIndex: Int {
        items.firstIndex(where: { $0.type == "Business"}) ?? 0
    }
    
    init() {
        if let encodedData = UserDefaults.standard.data(forKey: "Items") {
            /// Through [Expense].self we are trying to say don't instantiate this, we are just trying to tell you the type we want the encodedData to be decoded to.
            if let savedItems = try? JSONDecoder().decode([Expense].self, from: encodedData) {
                items = savedItems
                return
            }
        }
        items = []
    }
}
