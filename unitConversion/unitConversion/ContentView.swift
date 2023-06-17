//
//  ContentView.swift
//  unitConversion
//
//  Created by Sparsh Paliwal on 6/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var value: Double = 0.0
    @State private var inputUnit: String = "C"
    @State private var outputUnit: String = "F"
    private var tempUnits = ["C", "F", "K"]
    private var tempUnitToMeasurementMap: [String: UnitTemperature] = ["C": UnitTemperature.celsius, "F": UnitTemperature.fahrenheit, "K": UnitTemperature.kelvin]

    private var finalUnit: String {
        let inputUnitMeasurement = tempUnitToMeasurementMap[inputUnit] ?? .celsius
        let outputUnitMeasurement = tempUnitToMeasurementMap[outputUnit] ?? .celsius

        // 1. Measure is used to create a unit, you just need to tell swift 3 things - 1) its a Measurement using the Struct name, 2) Provide what is the value of your measurement 10, 20, 35 and son on, 3) What is unit of your measurement (feet, inches, celcius and so on, all of these have different Structs for example UnitLenght.feet, UnitAngle.degree, UnitTemprature.celcius, so bht baar yeh infer nahi karpata hai.)
        let inputValue = Measurement(value: value, unit: inputUnitMeasurement)
        // 2. Once you hav a base type change it to whatever you want
        let outputValue = inputValue.converted(to: outputUnitMeasurement)

        // 3. Formmatter is used for just displaying text on interface. It takes in a Measurement value and returns a string. Just ensure you give it unitOptions = .providedUnit or else its takes something of its choice by default, for example you might pass in a Kelvin Measurement, but it will take Celcius always.
        let formatter = MeasurementFormatter()
        // 4. This is where you pass .providedUnit
        formatter.unitOptions = .providedUnit
        let finalValue = formatter.string(from: outputValue)
        return finalValue
        // 5. You can use Double(1101.21312).formatted() and it will ready you number for being displayed on screen with comma seperators and more "1,101.21312".
    }
    

    var body: some View {
        Form {
            Section {
                TextField("value", value: $value, format: .number)
            }
            
            Section {
                Picker("Temprature input unit", selection: $inputUnit) {
                    ForEach(tempUnits, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)
            } header: {
                Text("Input Unit")
            }
            
            Section {
                Picker("Temprature input unit", selection: $outputUnit) {
                    ForEach(tempUnits, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)
            } header: {
                Text("Output Unit")
            }
            
            Section {
                Text(finalUnit)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
