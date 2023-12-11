//
//  MeView.swift
//  HotProspectsMain
//
//  Created by Sparsh Paliwal on 12/7/23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var name = "Sparsh"
    @State private var email = "sparsh@umd.edu"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                /// Providing textContentTypes helps system to offer suggestion to the text field, for example here system will autopouplate with your email id.
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .font(.title)
                /// Interpolation modifier makes the pictures sharp instead of blurry when they are stretched beyond their original size.
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu(menuItems: {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    })
            }
            .onAppear {
                updateQRCode()
            }
            .onChange(of: name) {
                updateQRCode()
            }
            .onChange(of: email) {
                updateQRCode()
            }
        }
    }
    
    func updateQRCode() {
        qrCode = generateQRCode(from: "\(name)\n\(email)")
    }
    /// Working with Core Image filters requires us to provide some input data, then convert the output CIImage into a CGImage, then that CGImage into a UIImage. We’ll be following the same steps here, except:
    /// 1. Our input for the filter will be a string, but the input for the filter is Data, so we need to convert that.
    /// 2. If conversion fails for any reason we’ll send back the “xmark.circle” image from SF Symbols.
    /// 3. If that can’t be read – which is theoretically possible because SF Symbols is stringly typed – then we’ll send back an empty UIImage.
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
