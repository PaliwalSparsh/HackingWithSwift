//
//  AddBookView.swift
//  bookworm
//
//  Created by Sparsh Paliwal on 9/7/23.
//

import SwiftUI

struct AddBookView: View {
    // We just need to use values from Environment and use it inside view
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    TextField("Book Title", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genres", selection: $genre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
                
                Section {
                    // This is the new super cool component multi-line text.
                    TextEditor(text: $review)
                    RatingsView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let book = Book(context: moc)
                        book.id = UUID()
                        book.title = title
                        book.author = author
                        book.rating = Int16(rating)
                        book.review = review
                        book.genre = genre
                        
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
