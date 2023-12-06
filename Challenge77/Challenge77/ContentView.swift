//
//  ContentView.swift
//  Challenge77
//
//  Created by Sparsh Paliwal on 12/6/23.
//

import SwiftUI

/// Use PHPickerViewController to add photo
/// Ask  user to name the photo
/// Save name and photo in document storage
/// Show list of names and uuid, sorted by name

struct ContentView: View {
    @EnvironmentObject var friends: Friends
    @State var showImagePicker = false
    @State var inputImage: UIImage?
    @State var newFriendCreated: Friend?
    
    var body: some View {
        NavigationView {
            List(friends.list) { friend in
                NavigationLink {
                    EditView(friendID: friend.id)
                } label: {
                    HStack {
                        Image(uiImage: getImage(friend: friend))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .background(Color(.red))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        Text(friend.name.capitalized)
                            .padding(.leading, 8)
                    }
                }
            }
            .navigationTitle("Friends")
            .toolbar {
                Button {
                    showImagePicker = true
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $inputImage)
                    .ignoresSafeArea()
            }
            .onChange(of: inputImage, initial: false) {
                addImageData()
            }
        }
    }
    
    func addImageData() {
        guard let inputImage = inputImage else { return }
        
        /// create a new friend with no name
        let newFriend = Friend(name: "")
        
        let path = FileManager.documentsDirectory.appendingPathComponent(newFriend.imageId)
        
        if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: path, options: [.atomic, .completeFileProtection])
        }

        friends.list.append(newFriend)
    }
}

func getImage(friend: Friend) -> UIImage {
    do {
        let path = FileManager.documentsDirectory.appendingPathComponent(friend.imageId)
        let imageData = try Data(contentsOf: path)
        return UIImage(data: imageData) ?? UIImage()
    } catch {
        print("Fetching image failed")
        return UIImage()
    }
}


#Preview {
    ContentView()
}
