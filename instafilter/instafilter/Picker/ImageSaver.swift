//
//  ImageSaver.swift
//  instafilter
//
//  Created by Sparsh Paliwal on 9/28/23.
//

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        /// Four parameters on this function are - So, the first one is the image to save, the second one is an object that should be notified about the result of the save (because it needs an object we were required to create this ImageSaver class), the third one is the method on the object that should be run(using #selector helps compiler to find saveCompleted function) this method name is used by Objective-C to find the actual code at runtime, and then there’s the fourth one. We aren’t going to be using it here, but you need to be aware of what it does: we can provide any sort of data here, and it will be passed back to us when our completion method is called.
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    /// @objc generates code that can be read by objective-C
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
