//
//  CompositionView.swift
//  ViewsAndModifiers
//
//  Created by Sparsh Paliwal on 6/20/23.
//

import SwiftUI

struct CompositionView: View {
    var helloWorldText = Text("Hello world")
    
    
    var helloWorldText2: some View {
        Text("Hello World 2 ")
    }
    
/// Now this next one which is commented will throw error because we have two views being returned.
///     ```var helloWorldText3: some View {
///         Text("Hello World 3.1")
///         Text("Hello World 3.2")
///     }```

/// Want to know where did we get ViewBuilder from? SwiftUI automatically applies @ViewBuilder to `var body: some View`. So when multiple views are provided to the var body computed property without being grouped using Group{} or VStack{} or HStack{} @ViewBuilder converts multiple views into a ViewTuple and the views start to make sense for SwiftUI.

/// So one another way of making this whole thing work would have been using Group -
///     ```var helloWorldText3: some View {
///         Group {
///                Text("Hello World 3.1")
///             Text("Hello World 3.2")
///         }
///     }```

/// Overall, @ViewBuilder internally enables SwiftUI to interpret and transform the embedded views within the closure or function into a valid view hierarchy, facilitating the construction of SwiftUI views using a convenient and readable syntax.

    @ViewBuilder var helloWorldText3: some View {
        Text("Hello World 3.1")
        Text("Hello World 3.2")
    }
    
    var body: some View {
        helloWorldText
            .font(.headline.bold())
        helloWorldText2
        helloWorldText3
    }
}

struct CompositionView_Previews: PreviewProvider {
    static var previews: some View {
        CompositionView()
    }
}
