//
//  RatingsView.swift
//  bookworm
//
//  Created by Sparsh Paliwal on 9/7/23.
//

import SwiftUI

struct RatingsView: View {
    // Binding can be used to take a value from parent container and update that value from child.
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1..<6) { number in
                Image(systemName: "star.fill")
                    .foregroundColor(number > rating ? .gray : .yellow)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        // .constant can be used in previews to quickly add a binding
        RatingsView(rating: .constant(4))
    }
}
