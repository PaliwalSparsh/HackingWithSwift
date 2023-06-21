//
//  Composition2.swift
//  ViewsAndModifiers
//
//  Created by Sparsh Paliwal on 6/20/23.
//

import SwiftUI

// You can easily compose views in SwiftUI
struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}


struct Composition2: View {
    var body: some View {
        VStack(spacing: 10) {
            // You can also provide properties on these views.
            CapsuleText(text: "First")
                .foregroundColor(.white)
            CapsuleText(text: "Second")
                .foregroundColor(.yellow)
        }
    }
}

struct Composition2_Previews: PreviewProvider {
    static var previews: some View {
        Composition2()
    }
}
