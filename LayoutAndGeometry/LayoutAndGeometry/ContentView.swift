//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Sparsh Paliwal on 12/13/23.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index) \(geo.frame(in: .global).minY)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: min((geo.frame(in: .global).minY)/fullView.size.height, 1), saturation: 1, brightness: 1))
                            .opacity(((geo.frame(in: .global).minY)/200) - 0.25)
                            .scaleEffect(min(max(0.5, geo.frame(in: .global).minY / 400), 1))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
