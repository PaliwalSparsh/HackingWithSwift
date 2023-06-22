//
//  DatesAndMore.swift
//  betterrest
//
//  Created by Sparsh Paliwal on 6/22/23.
//

import SwiftUI

struct DatesAndMore: View {
    @State private var sleepAmount = 8.0
    @State private var dateAndTime = Date.now
    var body: some View {
        VStack {
            /// 1. Stepper allows us to take precise values as input from users. We can use .formatted to display double values clearly. We can use in to define range of what should be maximum and minimum allowed values. This is awesome.
            Stepper("Sleep Hours \(sleepAmount.formatted())", value: $sleepAmount, in: 8...12, step: 0.25)
            /// 2. DatePicker is even crazier, you can define range by just saying show all dates from today to all upcoming days using Date.now... (crazy stuff). You can use displayedComponents to tell what components you want user to set.
            DatePicker("Select the date & time", selection: $dateAndTime, in: Date.now..., displayedComponents: [.date])
            
            VStack {
                /// 6. DISPLAYING DATES - for displaying dates we can use either .formatted() which returns a new string to Text, or we can use format: property of Text View and define which components we want from Date and Time.
                Text(Date.now.formatted())
                Text(Date.now.formatted(date: .abbreviated, time: .shortened))
                
                Text(Date.now, format: .dateTime.day())
                Text(Date.now, format: .dateTime.day().month())
                Text(Date.now, format: .dateTime.day().month().year())
            }.padding(.top, 64)
        }.onChange(of: dateAndTime, perform: {
            print("Changed \($0)")
        })
    }
    
    func exampleDates() {
        /// 3. WRITING DATES, Date() type in Swift contains date, min, hour, second, ms, month, week, timezone, leapseconds and so many more things. We only need certain components of these. So, we use DateComponents().
        /// 4. Next date(from: DateComponent) is used to create a date from a DateComponene for the specified calendar. Also, this method returns an optional so we need to define nil coalescing here.
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date.now
        
        /// 5. READING DATES - As before writing we define calendar, before reading we define calendar we want to use, and then use date components to read dateAndTime from DatePicker, we can also define what we want to read.
        let components2 = Calendar.current.dateComponents([.hour, .minute], from: dateAndTime)
        let hour = components2.hour ?? 0
        let minutes = components2.minute ?? 0
    }
}

struct DatesAndMore_Previews: PreviewProvider {
    static var previews: some View {
        DatesAndMore()
    }
}
