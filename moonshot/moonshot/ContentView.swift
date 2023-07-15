//
//  ContentView.swift
//  moonshot
//
//  Created by Sparsh Paliwal on 7/15/23.
//

import SwiftUI

struct ContentView: View {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            Text("Detail View")
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                Text(mission.displayName)
                                    .font(.subheadline.bold())
                                Text(mission.launchDate ?? "N/A")
                            }
                            .padding()
                            .background(.lightBackground)
                            .foregroundColor(.white)
                        }
                    }
                }
            }
            .background(.darkBackground)
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
