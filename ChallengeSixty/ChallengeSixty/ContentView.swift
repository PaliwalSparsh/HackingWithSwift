//
//  ContentView.swift
//  ChallengeSixty
//
//  Created by Sparsh Paliwal on 9/24/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUsers>

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("\(users.count) users")
                        .foregroundColor(Color(.secondaryLabel))
                    Spacer()
                }
                ForEach(Array(users.enumerated()), id: \.element) { index, user in
                    NavigationLink {
                        UserDetailView(users: users, userIndex: index)
                    } label: {
                        HStack {
                            Circle()
                                .frame(width: 10)
                                .foregroundColor(user.isActive ? Color(.green): Color(.red))
                            Text(user.name ?? "Unknown")
                            Spacer()
//                            Text("\(user.friends.count) friends")
//                                .foregroundStyle(Color(.secondaryLabel))
                        }
                    }
                }
            }
            .navigationTitle("Users")
        }
        .onAppear {
            Task {
                await getUsers()
            }
        }
    }
    
    /// Implement caching
    /// 1. GET data
    ///     - succeeds: on main actor update Core data, [done] add merge policy code.
    ///     - fails: don't update core data, stale data opens up app again.
    
    func getUsers() async {
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            print("request successful!!")
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let users = try decoder.decode([User].self, from: data)
            
            await MainActor.run {
                for user in users {
                    let cachedUser = CachedUsers(context: moc)
                    cachedUser.id = user.id
                    cachedUser.about = user.about
                    cachedUser.address = user.address
                    cachedUser.age = Int16(user.age)
                    cachedUser.company = user.company
                    cachedUser.email = user.email
                    cachedUser.isActive = user.isActive
                    cachedUser.name = user.name
                    cachedUser.registered = user.registered
                    cachedUser.tags = user.tags.joined(separator: ",")
                    for friend in user.friends {
                        let cachedFriend = CachedFriends(context: moc)
                        cachedFriend.id = friend.id
                        cachedFriend.name = friend.name
                        cachedUser.addToFriends(cachedFriend)
                    }
                    try? moc.save()
                }
                print("all data saved.")
            }
        } catch {
            print("Failed will use stale data!")
            /// Don't do anything let stale data render content
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
