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
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                VStack {
                                    Text(mission.displayName)
                                        .font(.subheadline.bold())
                                    Text(mission.launchDate ?? "N/A")
                                }
                                .frame(maxWidth: .infinity)

                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.lightBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(.darkBackground)
            .navigationTitle("Moonshot")
            /// We can force a particular color scheme on a view, this way all iOS elements such as nav bars and other stuff will turn light on dark based on what you define.
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
