//
//  ContentView.swift
//  FileZilla
//
//  Created by Sparsh Paliwal on 12/9/23.
//

import SwiftUI

struct ContentView: View {
    /// autoconnect means start timer as soon as view is created, and this is just publish, so we would also need a reciever here.
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var counter = 0

    @State private var text = ""
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        return VStack {
            Circle()
                .fill(.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        print("Active")
                    } else if newPhase == .inactive {
                        print("Inactive")
                    } else if newPhase == .background {
                        print("Background")
                    }
                }
            
            Spacer()
            Text("Sparsh")
                .onReceive(timer) { time in
                    if counter == 5 {
                        timer.upstream.connect().cancel()
                    } else {
                        print("The time is now \(time)")
                    }

                    counter += 1
                }
                .onLongPressGesture {
                    /// For more advanced gestures you should use the gesture() modifier – which takes in DragGesture, LongPressGesture, MagnificationGesture, RotationGesture, and TapGesture.
                    /// Use highPriorityGesture to give parent gesture more priority. Usually children is given more priority. if both child and parent have gestures attached to them. .simultaneuous allows both parent and child to execute.
                    text += "long"
                } onPressingChanged: { inProgress in
                    print("in progress")
                }
            Spacer()
            VStack {
                Text(text)
                    ///to make this element non-interactive
                    .allowsHitTesting(false)
                Spacer()
                Text("Hello, world!")
            }
            .contentShape(Rectangle())
            .onTapGesture(count: 3) {
                text += "Tapped"
            }
        }
    }
}

#Preview {
    ContentView()
}
