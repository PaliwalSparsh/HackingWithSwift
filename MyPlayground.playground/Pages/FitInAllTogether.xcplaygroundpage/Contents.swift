// This is content view code

import SwiftUI

// 1. :View here is not struct's datatype, its a protocol that the PracticeView has to conform to. The protocol says that Practice View should have a body computed property which returns some view
struct PracticeView: View {
    var message = /*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/
    var messageWithPrefix: String {
        "Sparsh says: " + message
    }
    
    // 2. This is a computed property with type some View, essentially we return some type of view from this property
    var body: some View {
        // 3. Text is also a struct which we instantiate here, this struct, obviously, conforms to `struct Text: View` View Protocol.
        // 4. Once we instantiate a struct we can call its methods such as padding.
        return Text(messageWithPrefix).padding(.top)
    }
}

// 5. Practice_Previews conforms to PreviewProvdier protocol and so on.
struct Practice_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
