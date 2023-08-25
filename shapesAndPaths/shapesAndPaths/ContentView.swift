//
//  ContentView.swift
//  shapesAndPaths
//
//  Created by Sparsh Paliwal on 8/7/23.
//

import SwiftUI

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        return path
    }
}

struct ContentView: View {
    @State var lineThickness = 0.0
    
    var body: some View {
        VStack {
            ArrowShape()
                .stroke(.black, style: StrokeStyle(lineWidth: lineThickness, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200)
                .background(Color.red)
                .animation(.easeInOut, value: lineThickness)
            
            Slider(value: $lineThickness, in: 1.0...20.0)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
