//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Sparsh Paliwal on 6/20/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("hello 1")
            // also selectively we can change one of the views later.
            .font(.subheadline.bold())
            Text("hello 2")
            Text("hello 3")
            // New cool modifier :P
            Text("hello 4")
                .blur(radius: 5)
        }
        // font is an example of an environment modifier it gets applied to all subviews in hierarchy
        .font(.title.bold())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
