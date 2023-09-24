//
//  UserDetailView.swift
//  ChallengeSixty
//
//  Created by Sparsh Paliwal on 9/24/23.
//

import SwiftUI

struct UserDetailView: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.email)
                .font(.body.bold())
            Text(user.registered.formatted(date: .complete, time: .shortened))
                .font(.subheadline)
            Text(user.about)
                .font(.body)
            ForEach(user.friends, id: \.id) { friend in
                Text(friend.name)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(user.name)
    }
}
