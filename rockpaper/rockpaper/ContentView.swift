//
//  ContentView.swift
//  rockpaper
//
//  Created by Sparsh Paliwal on 6/21/23.
//

import SwiftUI

struct ContentView: View {
    private var options = ["🪨", "📜", "✂️"]
    private var result = ["Win", "Lose"]
    @State private var cpuOption = Int.random(in: 0...2)
    @State private var round = 0
    @State private var score = 0
    @State private var showGameOverAlert = false
    
    private var availableOptions: [String] {
        options.filter({ $0 != options[cpuOption] })
    }
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.blue, .white], center: .top, startRadius: CGFloat(10 * (round + 4)), endRadius: 900)
                .ignoresSafeArea()
                .animation(.easeInOut, value: round)
            VStack(spacing: 64) {
                VStack {
                    VStack {
                        Text("Score \(score)")
                            .font(.title.bold())
                        Text("Round \(round + 1)")
                            .font(.subheadline.bold())
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                    .padding(.bottom, 80)

                    Text("CPU chose")
                        .font(.subheadline.bold())
                        .foregroundStyle(Color(.secondaryLabel))
                    Text("\(options[cpuOption]) and wants to \(result[round % 2])")
                        .font(.title.bold())
                }
                HStack {
                    ForEach(availableOptions, id: \.self) { option in
                        Button {
                            print(option)
                            nextRound(selectedOption: option)
                        } label: {
                            Text(option)
                            .font(.system(size: 48))
                            .padding(24)
                            .background(Color.black, in: RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .font(.title2.bold())
                .foregroundStyle(Color(.label))
            }.alert("Game Over! \n Your final score is \(score)", isPresented: $showGameOverAlert) {
                Button("OK", role: .cancel) {
                    round = 0
                    score = 0
                }
            }
        }
    }
    
    func nextRound(selectedOption userSelectedOption: String) {

        let currentResult = result[round % 2]
        let cpuSelectedOption = options[cpuOption]
        
        let toWin = ["🪨": "✂️", "📜": "🪨", "✂️": "📜"]
        let toLose = ["🪨": "📜", "📜": "✂️", "✂️": "🪨"]
        
        if (currentResult == "Win") {
            score = toWin[cpuSelectedOption] == userSelectedOption ? score + 1 : score - 1
        } else {
            score = toLose[cpuSelectedOption] == userSelectedOption ? score + 1 : score - 1
        }
        
        round = round + 1
        cpuOption = Int.random(in: 0...2)
        
        if (round == 10) {
            showGameOverAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
