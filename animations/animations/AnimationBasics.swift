//
//  AnimationBasics.swift
//  animations
//
//  Created by Sparsh Paliwal on 6/29/23.
//

import SwiftUI

struct AnimationBasics: View {
    @State private var animationAmount = 0.0
    @State private var animationAmount2 = 1.0
    @State private var animationAmount3 = 1.0
    
    /// 1. How animations happen in Swift? Swift checks if a state is changed, then it sees how does view look before state change and how does it look after change. Then swift animates from state A to state B. .
    
    var body: some View {
        ScrollView {
            /// 2. Implicit Animation - here we say, observe changes in state defined in value and whenever it changes perform the .spring() animation.
            Text("Tap me")
                .font(.title.bold())
                .frame(width: 200, height: 50)
                .onTapGesture {
                    animationAmount += 360
                }
                .scaleEffect((Int(animationAmount) / 360).isMultiple(of: 2) ? 1: 2)
                .animation(.spring(), value: animationAmount)
            
            Divider()
                .padding()
            
            /// 3. Binding Animation(also a type of implicit animation) - here we bind animation to a binding and say whenever this binding sets a value animate at all places using this value.
            Stepper("Pick a value: \(animationAmount2)", value: $animationAmount2.animation(), in: 1...10)
                .padding()
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemPurple))
                .frame(width: 100, height: 100)
                .rotation3DEffect(.degrees(60 * animationAmount2), axis: (x:0, y: 1, z:0))
                .padding(.bottom, 40)
            
            
            Divider()
                .padding()
            
            /// 4. Explicit animation - here we say for this particular state change animate all views which use the state inside this closure. We’re being explicit that we want an animation to occur when some arbitrary state change occurs: it’s not attached to a binding, and it’s not attached to a view, it’s just us explicitly asking for a particular animation to occur because of a state change.
            Button("Tap me (only text)") {
                withAnimation(.spring()) {
                    animationAmount += 360
                }
            }
            .padding(100)
            .background(Color(.systemMint), in: Circle())
            .foregroundStyle(Color(.white))
            .rotation3DEffect(.degrees(animationAmount), axis: (x:0, y:1, z:0))
            
            /// All places where animation amount is used will be animated in case of explicit animation.
            Text("other side")
                .font(.title.bold())
                .rotation3DEffect(.degrees(-animationAmount), axis: (x:0, y:1, z:0))
            
            Divider()
                .padding()
            
            Button("Tap me") {
                // Do something
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.red)
                    .opacity(2 - animationAmount3)
                    .scaleEffect(animationAmount3)
            }
            .animation(
                /// 5. .spring, .easeIn etc are essentially Animation.easeIn and so on struct, so we can use modifiers on them such as delay, repeatForever, repeatOnce and so on.
                .easeInOut(duration: 1)
                .repeatForever(autoreverses: false)
                , value: animationAmount3)
        }
        .padding()
        .onAppear {
            animationAmount3 += 2
        }
    }
}

struct AnimationBasics_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBasics()
    }
}
