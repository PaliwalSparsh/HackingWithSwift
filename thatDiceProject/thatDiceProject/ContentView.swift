//
//  ContentView.swift
//  thatDiceProject
//
//  Created by Sparsh Paliwal on 12/16/23.
//

import SwiftUI

class DieRolls: ObservableObject, Codable {
    @Published var sidesOfDice = 4
    @Published var currentRollValue = 0
    @Published var totalRollValue = 0
    @Published var possibleValues = [Int]()
        
    enum CodingKeys: CodingKey {
        case sideOfDice, currentRollValue, totalRollValue, possibleValues
    }
    
    init () {
        // we unwrap an optional using if let
        if let data = UserDefaults.standard.data(forKey: "savedData") {
            // we create JSONDecoder which throws an optional by using try?
            if let decoded = try? JSONDecoder().decode(DieRolls.self, from: data) {
                sidesOfDice = decoded.sidesOfDice
                currentRollValue = decoded.currentRollValue
                totalRollValue = decoded.totalRollValue
                possibleValues = decoded.possibleValues
            }
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sidesOfDice = try container.decode(Int.self, forKey: .sideOfDice)
        currentRollValue = try container.decode(Int.self, forKey: .currentRollValue)
        totalRollValue = try container.decode(Int.self, forKey: .totalRollValue)
        possibleValues = try container.decode([Int].self, forKey: .possibleValues)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sidesOfDice, forKey: .sideOfDice)
        try container.encode(currentRollValue, forKey: .currentRollValue)
        try container.encode(totalRollValue, forKey: .totalRollValue)
        try container.encode(possibleValues, forKey: .possibleValues)
    }
    
    func rollTheDie() {
        currentRollValue = Int.random(in: 1...sidesOfDice)
        totalRollValue += currentRollValue
        possibleValues = Array(repeating: Int.random(in: 1...currentRollValue), count: 4)
        save()
    }
    
    func save() {
        do {
            let encoded = try JSONEncoder().encode(self)
            UserDefaults.standard.setValue(encoded, forKey: "savedData")
        } catch {
            print("saving failed")
        }
    }
}

struct ContentView: View {
    @StateObject private var dieRolls = DieRolls()
    var body: some View {
        NavigationStack {
            Form {
                Section("input") {
                    Stepper("No of sides: \(dieRolls.sidesOfDice)", value: $dieRolls.sidesOfDice, in: 4...10)
                    Button("Roll the dice") {
                        dieRolls.rollTheDie()
                    }
                    .sensoryFeedback(.success, trigger: dieRolls.totalRollValue)
                }
                
                
                Section {
                    HStack {
                        Text("Current roll value")
                        Spacer()
                        Text("\(dieRolls.currentRollValue)")
                    }
                    HStack {
                        Text("Total roll values")
                        Spacer()
                        Text("\(dieRolls.totalRollValue)")
                    }
                }

                
            }
            .navigationTitle("Dice app")
        }
    }
}

#Preview {
    ContentView()
}
