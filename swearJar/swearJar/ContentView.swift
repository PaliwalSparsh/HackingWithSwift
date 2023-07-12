//
//  ContentView.swift
//  swearJar
//
//  Created by Sparsh Paliwal on 7/11/23.
//

import SwiftUI

/// Here when jar is passed to this view it's a copy of the struct, so we cannot change the original struct from here.
/// If want to move the same object from one view to another our original data should be class :)
struct JarDetailView: View {
    var jar: Jar
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(jar.items) { item in
                    HStack {
                        Text(item.amount, format: .currency(code: "USD"))
                            .font(.subheadline.bold())
                        Spacer()
                        Text(item.date.formatted(date: .abbreviated, time: .shortened))
                    }
                }
            }
            .navigationTitle("Jar Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

struct JarView: View {
    @State var jar = Jar()
    @State var showDetailsSheet = false
    let amount = [1.0, 2.0, 3.0]
    var body: some View {
        NavigationView {
            VStack {
                Text(jar.totalAmount, format: .currency(code: "USD"))
                    .font(.largeTitle.bold())
                HStack {
                    ForEach(amount, id: \.self) { value in
                        Button {
                            jar.items.append(JarItem(amount: value, date: Date.now))
                        } label: {
                            Text(value, format: .currency(code: "USD"))
                        }
                        .buttonStyle(.bordered)
                    }
                }
                Button("Details") {
                    showDetailsSheet = true
                }
            }
            .sheet(isPresented: $showDetailsSheet){
                JarDetailView(jar: jar)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        JarView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
