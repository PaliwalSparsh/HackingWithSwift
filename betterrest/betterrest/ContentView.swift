// This is same as ContentView-v1, just with some minor UI changes.

//  ContentView.swift
//  betterrest
//
//  Created by Sparsh Paliwal on 6/22/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffee = 0.0
    
    /// Think of computed property as a function, its nothing but a convinient getter and setter.
    private var recommendedSleepTime: String {
        do {
            /// 1. Initialise ML model, config might have been required if we wanted to pass in some important configurations, however don't do it in most of the cases.
            let config = MLModelConfiguration()
            /// 2. When you drag and drop a model, xcode automatically creates a class from it. You can see details of class in File navigator.
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hours = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            
            /// 3. Here we get prediction from the model :)
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: coffee)
            
            /// 4. In Swift you can subtract seconds form a Date() directly to get a new date.
            let sleepTime = wakeUp - prediction.actualSleep
            
            return "You need to sleep at \(sleepTime.formatted(date: .omitted, time: .shortened))"
        } catch {
            return "Oops there was an Error!"
        }
    }
    
    /// 0. This is too dope, if we want to initiate a state property with a default value we can use static type as they are initialised separately and not at the time of intantiation of the Struct or class.
    static private var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                HStack() {
                    Text("When do you want to wake up?")
                        .font(.subheadline.bold())
                    Spacer()
                    DatePicker("Enter wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep?")
                        .font(.subheadline.bold())
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in:4...12, step: 0.25)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily Coffee Intake")
                        .font(.subheadline.bold())
                    Stepper("\(coffee.formatted()) cups", value: $coffee, in:0...20, step: 1)
                }
                VStack {
                    Text(recommendedSleepTime)
                        .font(.title3.bold())
                }.padding(.vertical, 8)
            }
            .navigationTitle("Better Rest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
