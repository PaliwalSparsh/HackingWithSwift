//
//  ContentView.swift
//  animations
//
//  Created by Sparsh Paliwal on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    var body: some View {
        VStack {
            Button("Hello") {
                withAnimation(.spring()) {
                    animationAmount += 360
                }
            }
            .padding(100)
            .background(Color(.systemMint), in: Circle())
            .foregroundStyle(Color(.white))
            .rotation3DEffect(.degrees(animationAmount), axis: (x:0, y:1, z:0))
            
            Text("other side")
                .font(.title.bold())
                .rotation3DEffect(.degrees(-animationAmount), axis: (x:0, y:1, z:0))
                
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
