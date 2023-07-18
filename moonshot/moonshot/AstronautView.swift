//
//  AstronautView.swift
//  moonshot
//
//  Created by Sparsh Paliwal on 7/18/23.
//

import SwiftUI

struct AstronautView: View {
    var astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        AstronautView(astronaut: astronauts["grissom"]!)
    }
}
