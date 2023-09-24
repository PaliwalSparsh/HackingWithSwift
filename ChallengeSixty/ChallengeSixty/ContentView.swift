//
//  ContentView.swift
//  ChallengeSixty
//
//  Created by Sparsh Paliwal on 9/24/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var masterModel = MasterModel()

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("\(masterModel.users.count) users")
                        .foregroundColor(Color(.secondaryLabel))
                    Spacer()
                }
                ForEach(masterModel.users, id: \.id) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        HStack {
                            Circle()
                                .frame(width: 10)
                                .foregroundColor(user.isActive ? Color(.green): Color(.red))
                            Text(user.name)
                            Spacer()
                            Text("\(user.friends.count) friends")
                                .foregroundStyle(Color(.secondaryLabel))
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
    
    func getUsers() async {
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            masterModel.users = try decoder.decode([User].self, from: data)
        } catch {
            fatalError()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
