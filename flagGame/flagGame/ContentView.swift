//
//  ContentView.swift
//  flagGame
//
//  Created by Sparsh Paliwal on 6/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var totalScore = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.mint, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack(spacing: 20) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                    // 1. This is an excellent way to provide semantic font, also we can give bold, italics etc. here itself.
                        .font(.subheadline.bold())
                    Text("\(countries[correctAnswer])")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                }
                
                ForEach(0..<3) { number in
                    Button {
                        buttonTap(number: number)
                    } label: {
                        Image(countries[number])
                        // 2. Rendering mode original use makes the image not turn into bluish tint that's ususally seen on buttons. ClipShape is used to clip shape. Duuuuhh..
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                    }
                }
                
                Text("Total Score \(totalScore)")
                    .foregroundStyle(.white)
                    .font(.headline.bold())
            }
        }
    }
    
    func buttonTap(number: Int) {
        if( number == correctAnswer ) {
            totalScore += 1
        } else {
            totalScore -= 1
        }
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
