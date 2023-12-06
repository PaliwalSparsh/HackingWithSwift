//
//  EditView.swift
//  Challenge77
//
//  Created by Sparsh Paliwal on 12/6/23.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var friends: Friends
    var friendID: UUID
    var friendIndex: Int {
        friends.list.firstIndex(where: {$0.id == friendID}) ?? 0
    }
    
    var body: some View {
        Form {
            Image(uiImage: getImage(friend: friends.list[friendIndex]))
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
            TextField("Name", text: $friends.list[friendIndex].name)
        }
    }
}
