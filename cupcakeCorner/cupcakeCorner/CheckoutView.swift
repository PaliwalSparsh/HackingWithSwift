//
//  CheckoutView.swift
//  cupcakeCorner
//
//  Created by Sparsh Paliwal on 8/29/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                Button("Checkout") {
                    
                }
                .padding()
            }
        }

    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}

//
//if (phase.error != nil) {
//    // if the async image is in error phase show error
//    Text("Unable to load the image")
//} else if (phase.image != nil) {
//    // if the async image is loaded show the image, we can use resizable and scale to fit only on loaded image.
