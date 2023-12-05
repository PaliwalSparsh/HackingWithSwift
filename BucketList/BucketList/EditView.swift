//
//  EditView.swift
//  BucketList
//
//  Created by Sparsh Paliwal on 11/28/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    @StateObject private var viewModel: ViewModel

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        ProgressView()
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline.bold())
                            + Text(": ")
                            + Text(page.description).italic()
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    let newLocation = viewModel.createNewLocation()
                    onSave(newLocation)
                    dismiss()
                }
            }.task {
                await viewModel.fetchNearbyPlace()
            }
        }
    }
    
    /// Remember, @escaping means the function is being stashed away for user later on, rather than being called immediately, and it’s needed here because the onSave function will get called only when the user presses Save.
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }
}

/// Remember, @escaping means the function is being stashed away for user later on, rather than being called immediately, and it’s needed here because the onSave function will get called only when the user presses Save.
//init(location: Location, onSave: @escaping(Location) -> Void) {
//    self.location = location
//    self.onSave = onSave
//    ///  what initial values should we use for the name and description properties? Previously we’ve used @State with initial values, but we can’t do that here – their initial values should come from what location is being passed in, so the user sees the saved data.
//    ///  The solution is to create a new initializer that accepts a location, and uses that to create State structs using the location’s data. This uses the same underscore approach we used when creating a fetch request inside an initializer, which allows us to create an instance of the property wrapper not the data inside the wrapper.
//    _name = State(initialValue: location.name)
//    _description = State(initialValue: location.description)
//}
