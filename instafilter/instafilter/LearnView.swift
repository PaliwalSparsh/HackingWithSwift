//
//  Learnview.swift
//  instafilter
//
//  Created by Sparsh Paliwal on 9/19/23.
//

import SwiftUI

struct LearnView: View {
    @State private var showConfirmationDialog = false
    @State private var backgroundColor = Color.red
    
    @State private var blurAmount = 0.0 {
        didSet {
            /// Trying to log blurAmount in this manner you will soon realise that $binding made on slider logs nothing while blurAmount=... set in button prints the thing below. The reason behind this is how @State struct stores the blurAmount internally. So never, do didSet, instead use onChange to log values of State.
            print("The blue amount is \(blurAmount)")
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(width: 300, height: 300)
                .background(backgroundColor)
                .onTapGesture {
                    showConfirmationDialog.toggle()
                }
                .blur(radius: blurAmount)
                .confirmationDialog("Change background", isPresented: $showConfirmationDialog) {
                    Button("Red") { backgroundColor = .red }
                    Button("Green") { backgroundColor = .green }
                    Button("Blue") { backgroundColor = .blue }
                } message: {
                    Text("Select Color")
                }
                
                Spacer()
                
                Divider()
            
                Spacer()
            
                Slider(value: $blurAmount, in: 0...20)
                Button("Random Blur") {
                    blurAmount = Double.random(in: 0...20)
                }
            
                Spacer()
        }.onChange(of: blurAmount) { newValue in
            print(newValue)
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
