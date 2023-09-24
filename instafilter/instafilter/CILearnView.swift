//
//  CILearnView.swift
//  instafilter
//
//  Created by Sparsh Paliwal on 9/23/23.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

///Apart from SwiftUI’s Image view, the three other image types are:
///1. UIImage, which comes from UIKit. This is an extremely powerful image type capable of working with a variety of image types, including bitmaps (like PNG), vectors (like SVG), and even sequences that form an animation. UIImage is the standard image type for UIKit, and of the three it’s closest to SwiftUI’s Image type.
///2. CGImage, which comes from Core Graphics. This is a simpler image type that is really just a two-dimensional array of pixels.
///3. CIImage, which comes from Core Image. This stores all the information required to produce an image but doesn’t actually turn that into pixels unless it’s asked to. Apple calls CIImage “an image recipe” rather than an actual image.

struct CILearnView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        /// We took example image and converted it to CIImage as CIfilters only work on CIimage data.
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        /// We performed filtering on the image.
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.intensity = 1
        currentFilter.inputImage = beginImage
        
        /// Then converted the output CIImage to CGImage to UIImage to Image.
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
}

struct CILearnView_Previews: PreviewProvider {
    static var previews: some View {
        CILearnView()
    }
}
