//
//  UserDetailView.swift
//  ChallengeSixty
//
//  Created by Sparsh Paliwal on 9/24/23.
//

import SwiftUI

struct UserDetailView: View {
    var users: FetchedResults<CachedUsers>
    var userIndex: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(users[userIndex].email ?? "Unknown")
                .font(.body.bold())
            Text(users[userIndex].about ?? "Unknown")
                .font(.body)
//            ForEach(users[userIndex].friends, id: \.id) { friend in
//                Text(friend.name)
//            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(users[userIndex].name ?? "Unknown")
    }
}


///             Text(users[userIndex]?.registered.formatted(date: .complete, time: .shortened) ?? "Unknown").font(.subheadline)
