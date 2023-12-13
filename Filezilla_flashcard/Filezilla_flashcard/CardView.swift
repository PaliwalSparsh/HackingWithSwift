//
//  CardView.swift
//  Filezilla_flashcard
//
//  Created by Sparsh Paliwal on 12/12/23.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    let card: Card
    var removal: (() -> Void)? = nil
    @State private var offset = CGSize.zero
    @State private var isShowingAnswer = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    differentiateWithoutColor ? .white : .white
                    .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text(card.prompt)
                    .font(.body.bold())
                    .foregroundStyle(.black)
                if(isShowingAnswer) {
                    Text(card.answer)
                        .font(.body.bold())
                        .foregroundStyle(.gray)
                }
            }.multilineTextAlignment(.center)
        }
        .onTapGesture {
            withAnimation {
                isShowingAnswer.toggle()
            }
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 2, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        removal?()
                    } else {
                        offset = .zero
                    }
                    
                }
        )
        .sensoryFeedback(.success, trigger: offset.width == 100)
        .sensoryFeedback(.error, trigger: offset.width == -100)
        .animation(.spring, value: offset)
    }
}

#Preview {
    CardView(card: Card.example)
}
