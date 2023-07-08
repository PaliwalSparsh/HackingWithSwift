//
//  ContentView.swift
//  edutainment
//
//  Created by Sparsh Paliwal on 7/7/23.
//

import SwiftUI

struct ContentView: View {
    let tableRange = 1...10
    
    @State var isGameStarted = false
    @State var practiceNumber = 2
    @State var productNumber = 1
    @State var answer = 0
    @State var rounds = 5
    @State var score = 0
    var body: some View {
        if (isGameStarted) {
            VStack {
                Button("Main Menu") {
                    isGameStarted.toggle()
                }
                .buttonStyle(.bordered)
                .padding(20)
                Text("Your score is \(score)")
                    .font(.subheadline.bold())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
                    .transition(.push(from: .leading))
                
                Spacer()
                
                Text("Enter the Product of \(practiceNumber)X\(productNumber)")
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
                    .transition(.push(from: .leading))
                TextField("Enter the Product of \(practiceNumber) X \(productNumber)", value: $answer, format: .number)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
                    .transition(.push(from: .leading))
                    .foregroundStyle(Color(.systemBlue))
                
                Spacer()
                
                Button {
                    // Next round
                    withAnimation {
                        if(practiceNumber*productNumber == answer) {
                            score += 1
                        } else {
                            score -= 1
                        }
                        
                        productNumber = tableRange.randomElement() ?? 1
                        rounds = rounds - 1
                        
                        // Game restarts
                        if(rounds == 0) {
                            isGameStarted = false
                            score = 0
                            rounds = 5
                        }
                    }
                } label: {
                    Text(rounds == 1 ? "Last Round": "Next Round")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(20)
            }
        } else {
            VStack {
                Spacer()
                Text("Select which table you want to practice?")
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 56))], spacing: 12) {
                    ForEach(2..<14) { i in
                        Button {
                            practiceNumber = i
                        } label: {
                            Text("\(i)")
                                .font(.title.bold())
                                .frame(width: 40, height: 40)
                        }
                        .buttonStyle(.bordered)
                    }
                }.frame(maxWidth: 300)
                
                Spacer()
                    .frame(height: 80)
                
                Stepper("\(rounds) Rounds", value: $rounds, in: 1...10)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
                Spacer()
                
                Button {
                    withAnimation() {
                        isGameStarted = true
                    }
                } label: {
                    Text("Start Game")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(20)
            }
            .transition(.opacity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
