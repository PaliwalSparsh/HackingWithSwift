//
//  Challenge.swift
//  ViewsAndModifiers
//
//  Created by Sparsh Paliwal on 6/21/23.
//

import SwiftUI

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .foregroundStyle(.blue)
    }
}

extension View {
    func largeBlueTitle() -> some View {
        self.modifier(LargeBlueTitle())
    }
}

struct Challenge: View {
    @State private var isColorRed: Bool = false
    var body: some View {
        VStack {
            Text("Large Blue Title")
                .largeBlueTitle()
            Button("Hello World") {
                isColorRed.toggle()
            }
            .foregroundStyle(isColorRed ? .red: .blue)
        }
    }
}

struct Challenge_Previews: PreviewProvider {
    static var previews: some View {
        Challenge()
    }
}
