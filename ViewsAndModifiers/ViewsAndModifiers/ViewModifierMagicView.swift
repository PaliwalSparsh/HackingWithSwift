//
//  ViewModifierMagicView.swift
//  ViewsAndModifiers
//
//  Created by Sparsh Paliwal on 6/20/23.
//

import SwiftUI

// 1 & 2 Simple Modifer
struct ColoredShadowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.yellow)
            .blur(radius: 3)
    }
}

// 3 Complex Modifier
struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    // 0. Modifier in view entension
    func boldAndLargeText() -> some View {
        self.font(.title.bold())
    }
    
    // 1. A simple view modifier
    func coloredShadowStyle() -> some View {
        self.modifier(ColoredShadowStyle())
    }
    
    // 3. A complex view modifier with properties. If you want to use properties like this you cannot use "0. Modifier in view entension"
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ViewModifierMagicView: View {
    var body: some View {
        VStack {
            // 0. We can directly compose modifiers in the View extensions.
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .boldAndLargeText()
            
            // 1. We can use "modifier" modifier to provide our custom viewModifier, for better encapsulation.
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .boldAndLargeText()
                .modifier(ColoredShadowStyle())
            
            // 2. We can simplify custom viewModifier even more by adding them as view extensions.
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .boldAndLargeText()
                .coloredShadowStyle()
            
            // 3. This is a complex
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .boldAndLargeText()
                .watermarked(with: "Sparsh")
        }
        
    }
}

struct ViewModifierMagicView_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierMagicView()
    }
}
