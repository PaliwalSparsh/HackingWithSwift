//
//  ContentView.swift
//  CoreDataConcepts
//
//  Created by Sparsh Paliwal on 9/14/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var movies: FetchedResults<Movie>
    
    /// we can have different types of format in NSPredicate.
    /// 1. NOT – NOT title == "Star Wars"
    /// 2. < > ==  - NSPredicate(format: "name < %@", "F"))
    /// 3. IN - NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
    /// 4. BEGINSWITH - NSPredicate(format: "name BEGINSWITH %@", "E"))
    /// 5. CONTAINS - can be used same as BeginsWith.

    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "title == %@", "Star Wars")) var starWarsMovies: FetchedResults<Movie>
    
    var body: some View {
        VStack {
            List {
                ForEach(movies) { movie in
                    Text(movie.wrappedTitle)
                }
            }
            Button("Add") {
                let movie = Movie(context: moc)
                movie.title = "Mission Impossible"
                movie.director = "Tom hanks"
                movie.year = 2023
            }
            Button("Save") {
                /// Apple recommends don't run save unless you check if there are changes, this helps with performance.
                if(moc.hasChanges) {
                    try? moc.save()
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
