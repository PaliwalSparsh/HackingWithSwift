//
//  ContentView.swift
//  bookworm
//
//  Created by Sparsh Paliwal on 9/1/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showAddView = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(books) { book in
                        NavigationLink {
                            Text(book.title ?? "Unknown Title")
                        } label: {
                            HStack {
                                Image(systemName: "book")
                                    .font(.largeTitle)

                                VStack(alignment: .leading) {
                                    Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                    Text(book.author ?? "Unknown Author")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddBookView()
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
