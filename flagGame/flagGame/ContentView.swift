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
    @State private var showWrongAnswerAlert = false
    @State private var lastWrongTappedNumber = 0
    @State private var rounds = 0
    @State private var showGameFinishAlert = false
    
    @State private var selectedFlag = -1
    @State private var isTapped = false
    
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
                        withAnimation(.easeInOut(duration: 0.4)) {
                            selectedFlag = number
                            isTapped = true
                        }
                        /// DispatchQueue helped us execute buttonTap once animation gets over.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                buttonTap(number: number)
                        }

                    } label: {
                        Image(countries[number])
                        // 2. Rendering mode original use makes the image not turn into bluish tint that's ususally seen on buttons. ClipShape is used to clip shape. Duuuuhh..
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        // 3. This is how you can add shadow and opacity, radius is essentailly how much blur we want and we also have x and y as args that can be passed to shadow.
                            .shadow(color: .black.opacity(0.4), radius: 6)
                    }
                    .scaleEffect(isTapped ? (number == selectedFlag ? 1.2 : 0.8) : 1)
                    .opacity(isTapped ? (number == selectedFlag ? 1 : 0.6) : 1)
                    .animation(.spring(), value: selectedFlag)
                    .transition(.slide)
                }
                
                VStack {
                    Text("Total Score \(totalScore)")
                        .foregroundStyle(.white)
                        .font(.headline.bold())
                    Text("Round \(rounds)")
                        .foregroundStyle(.secondary)
                        .font(.body.bold())
                }

            }
            // This is shown after the alert below
            .alert("Your final score is \(totalScore)", isPresented: $showGameFinishAlert, actions: {
                Button("Cancel", role: .cancel, action: startNextGame)
            })
            // This alert is shown first, in case during the last round user gets their stuff wrong
            .alert("You accidentally selected \(countries[lastWrongTappedNumber])", isPresented: $showWrongAnswerAlert, actions: {
                Button("Cancel", role: .cancel, action: startNextRound)
            })
        }
    }
    
    func buttonTap(number: Int) {
        if( number == correctAnswer ) {
            totalScore += 1
            startNextRound()
        } else {
            totalScore -= 1
            showWrongAnswerAlert = true
            lastWrongTappedNumber = number
        }
        rounds += 1
        
        if(rounds == 9) {
            showGameFinishAlert = true
        }
    }
    
    func startNextRound() {
        correctAnswer = Int.random(in: 0...2)
        selectedFlag = -1
        isTapped = false
    }
    
    func startNextGame() {
        rounds = 0
        totalScore = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
