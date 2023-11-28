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
    @State private var inputImage: UIImage?
    
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
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }

}

struct PickerMainView_Previews: PreviewProvider {
    static var previews: some View {
        PickerMainView()
    }
}
