//
//  ImagePicker.swift
//  instafilter
//
//  Created by Sparsh Paliwal on 9/23/23.
//

import SwiftUI
import PhotosUI

/// UIViewControllerRepresentable conforms to view but doesn't require body func. It's required to wrap a UIView.
/// A UIKit view has 3 important elements –
///  1. UIView, which is the parent class of all views in the layouts. So, labels, buttons, text fields, sliders, and so on – those are all views.
///  2. UIViewController, which is designed to hold all the code to bring views to life.
///  3. UIKit uses a design pattern called delegation to decide where work happens. So, when it came to deciding how to respond to a text field changing, we’d create a custom class with our functionality and make that the delegate of our text field.

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    /// Used for handling communication between outside world and PHPickerController
    /// Inheriting from NSObject lets Objective-C query Coordinator what functionality it supports. Conforming to PHPickerViewControllerDelegate protocol allows to provide/write those functionalities.
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Tell the picker to go away
            picker.dismiss(animated: true)

            // Exit if no selection was made
            guard let provider = results.first?.itemProvider else { return }

            // If this has an image we can use, use it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    /// typealias UIViewControllerType = PHPickerViewController
    /// When you write the above code compiler shows warning, fix that warning and you will be presented with a make and a update function whcih are required to create and update the UIView. Then you can remove this typealias line, it's just a shortcut to get these exact functions.

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        /// This lines says whenever any action happens in PHPickerView, such as user selecting an image, report that action to the delegate
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    /// SwiftUI automatically calls makeCoordianator.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
