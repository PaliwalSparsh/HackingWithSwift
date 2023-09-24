//
//  PickerMainView.swift
//  instafilter
//
//  Created by Sparsh Paliwal on 9/23/23.
//

import SwiftUI

struct PickerMainView: View {
    @State private var image: Image?
    @State private var showImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Show picker") {
                showImagePicker.toggle()
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker()
        }
    }
}

struct PickerMainView_Previews: PreviewProvider {
    static var previews: some View {
        PickerMainView()
    }
}
