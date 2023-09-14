//
//  ContentView.swift
//  bookworm
//
//  Created by Sparsh Paliwal on 9/1/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    /// You can have several sort descriptors, swift uses first to sort, but if two have same value for first descriptor then second one is used to fix the draw.
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showAddView = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(books) { book in
                        NavigationLink {
                            DetailView(book: book)
                        } label: {
                            HStack {
                                Image(systemName: "book")
                                    .font(.largeTitle)
                                    .foregroundStyle(book.rating == 1 ? .red: .black)

                                VStack(alignment: .leading) {
                                    Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                    Text(book.author ?? "Unknown Author")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .badge(Text("\(Image(systemName: "star.fill")) \(book.rating)"))
                        }
                        
                    }.onDelete(perform: handleDeleteBook)
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
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddView) {
                AddBookView()
            }
        }
    }
    
    func handleDeleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
