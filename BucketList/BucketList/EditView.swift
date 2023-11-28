//
//  EditView.swift
//  BucketList
//
//  Created by Sparsh Paliwal on 11/28/23.
//

import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void
    
    @State var name = ""
    @State var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }
                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        ProgressView()
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
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
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
            }.task {
                await fetchNearbyPlace()
            }
        }
    }
    
    /// Remember, @escaping means the function is being stashed away for user later on, rather than being called immediately, and it’s needed here because the onSave function will get called only when the user presses Save.
    
    init(location: Location, onSave: @escaping(Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        ///  what initial values should we use for the name and description properties? Previously we’ve used @State with initial values, but we can’t do that here – their initial values should come from what location is being passed in, so the user sees the saved data.
        ///  The solution is to create a new initializer that accepts a location, and uses that to create State structs using the location’s data. This uses the same underscore approach we used when creating a fetch request inside an initializer, which allows us to create an instance of the property wrapper not the data inside the wrapper.
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    func fetchNearbyPlace() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            ///In Swift, .self is a way to refer to the type itself rather than an instance of that type. When you use .self after a type name, it refers to the type itself as a value.
            let items = try JSONDecoder().decode(Result.self, from: data)
            
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
}
