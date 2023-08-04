//
//  MissionView.swift
//  moonshot
//
//  Created by Sparsh Paliwal on 7/18/23.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct CrewList: View {
    var crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(crew, id: \.role) { crew in
                    NavigationLink {
                        Text(crew.astronaut.name)
                    } label: {
                        Image(crew.astronaut.id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                        VStack(alignment: .leading) {
                            Text(crew.astronaut.name)
                                .font(.body.bold())
                            Text(crew.role)
                                .font(.caption)
                        }
                        .padding(.horizontal)
                        .foregroundStyle(.white)
                    }
                    .background(.lightBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }

    }
}

struct MissionView: View {
    var mission: Mission
    var crew: [CrewMember]
    
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 0.6 * geo.size.width)
                Text(mission.launchDate ?? "N/A")
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.body.bold())
                        .padding(.vertical)
                    Text(mission.description)
                    Text("Crew")
                        .font(.body.bold())
                        .padding(.vertical)
                }
                .padding(.horizontal)
                CrewList(crew: crew)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
        
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        let missions:[Mission] = Bundle.main.decode("missions.json")
        let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")

        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
