//
//  DetailView.swift
//  bookworm
//
//  Created by Sparsh Paliwal on 9/14/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            VStack {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                Text(book.date ?? Date.now, format: .dateTime.day().month().year())
                Text(book.author ?? "N/A")
                    .font(.title.bold())
                    .foregroundColor(Color(.secondaryLabel))
                RatingsView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)
                Text(book.review ?? "")
            }
        }
        .navigationTitle(book.title ?? "Unknown Title")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                showDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        .alert("Are you sure you want to delete?", isPresented: $showDeleteAlert ) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                deleteBook()
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        
        // You can dismiss any view, it just goes to previous view when you dismiss current one.
        dismiss()
    }
}

