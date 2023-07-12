//
//  Expense.swift
//  iExpense
//
//  Created by Sparsh Paliwal on 7/11/23.
//

import Foundation

//enum ExpenseType {
//    case business
//    case personal
//}

// To conform to Identifiable we need to just ensure that our struct has a ID property.
// Codable allows complex data such as Struct to be converted to primitive type such as JSON String.
struct Expense: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
