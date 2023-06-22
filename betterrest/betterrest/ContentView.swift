//
//  ContentView.swift
//  betterrest
//
//  Created by Sparsh Paliwal on 6/22/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Examples", destination: DatesAndMore())

            }
            .padding()
        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
