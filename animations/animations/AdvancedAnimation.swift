//
//  AdvancedAnimation.swift
//  animations
//
//  Created by Sparsh Paliwal on 6/29/23.
//

import SwiftUI

/// The viewmodifier along with .modifier(active, identity) is used to create custom transition.
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    let opacityAmount: Double

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            /// clipped clips content to the frame rectangle
            .clipped()
            .opacity(opacityAmount)
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        /// active and identity are states essentially from and to.
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading, opacityAmount: 0),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading, opacityAmount: 1)
        )
    }
}


struct AdvancedAnimation: View {
    let letters = Array("Hello World!")
    @State private var offset = CGSize.zero
    
    @State private var animation = false
    
    @State private var showBox = false
    @State private var showBox2 = false
    
    @State private var showRectangle = false
    
    var body: some View {
        
        VStack {
            Group {
                
                /// By using multiple animations you can define how many modifiers you want to animation, an animation modifier animates all modifers up until the next animation modifier it finds. Everything above is handled by that next animation modifier and so on. You can use nil to not animate a set of modifiers. In the example below backgorund is not getting animated, but foreground color is getting animated.
                Button("multiple animation modifier") {
                    animation.toggle()
                }
                .font(.title.bold())
                .background(animation ? .blue : .mint)
                .animation(nil, value: animation)
                .foregroundStyle(animation ? .white : .cyan)
                .animation(.default, value: animation)
                
                Divider()
                    .padding()
                
                /// Transition
                /// You also need to define how exactly the animation will be animated in this case which is .easeInOut
                Toggle("Transition example - show box", isOn: $showBox.animation(.easeInOut(duration: 0.4)))
                if showBox {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemTeal))
                        .frame(width: 200, height: 200)
                    /// You need to define transition on the element you want to animate. It can be as simple as .transition(.scale) or asymmetric as below.
                        .transition(.asymmetric(insertion: .opacity, removal: .scale))
                }
                
                Divider()
                    .padding()
                
                /// In most cases you will be using trasition alongside withAnimation because we usually move / hide views when a specific state change occurs.
                Button("Show/hide box 2") {
                    withAnimation {
                        showBox2.toggle()
                    }
                }
                if showBox2 {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemOrange))
                        .frame(width: 200, height: 200)
                    /// You need to define transition on the element you want to animate. It can be as simple as .transition(.scale) or asymmetric as below.
                        .transition(.slide)
                }
                
                Divider()
                    .padding()
                
                /// Animating gestures
                HStack(spacing: 0) {
                    ForEach(0..<letters.count, id: \.self) { num in
                        Text(String(letters[num]))
                            .font(.title.bold())
                            .offset(offset)
                            .animation(.default.delay(Double(num)/20), value: offset)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged {
                            offset = $0.translation
                        }
                        .onEnded { _ in
                            offset = CGSize.zero
                        }
                )
                
                
                Divider()
                    .padding()
            }
            
            /// Transition Modifier
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)
                
                if showRectangle {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                        .zIndex(1)

                }
            }
            .onTapGesture {
                withAnimation {
                    showRectangle.toggle()
                }
            }
            
        }
    }
}

struct AdvancedAnimation_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedAnimation()
    }
}
