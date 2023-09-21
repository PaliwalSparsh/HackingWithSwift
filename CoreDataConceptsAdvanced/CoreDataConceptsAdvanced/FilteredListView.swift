//
//  FilteredListView.swift
//  CoreDataConceptsAdvanced
//
//  Created by Sparsh Paliwal on 9/20/23.
//

import SwiftUI

struct FilteredListView: View {
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    /// score refers to the value inside the property wrapper.
    /// _score refers to the property wrapper.
    /// $score refers to the property wrapper's projected value; in the case of @State, that is a Binding.
    ///
    /// @State var score = 0 gets compiled to –
    /// private var _score: = State<Int>(wrappedValue: 0)
    ///    var score: Int {
    ///        get { return _score.wrappedValue }
    ///        set { _score.wrappedValue = newValue }
    ///   }
    ///    var $score: Binding<Int> {
    ///        get { return _score.projectedValue }
    ///    }
    /// Will help a lot with understanding stuff - https://www.hackingwithswift.com/forums/swiftui/variable-confusion/12888

    init(filter: String) {
        /// by using underscored fetchRequest here we are completely reassigning the fetchRequest variable, we are not giving its wrappedValue a new value
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
}
