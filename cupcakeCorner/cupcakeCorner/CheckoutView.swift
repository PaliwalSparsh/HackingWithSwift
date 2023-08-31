//
//  CheckoutView.swift
//  cupcakeCorner
//
//  Created by Sparsh Paliwal on 8/29/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State var alertMessage = ""
    @State var showAlertMessage = false
    
    var body: some View {
        ScrollView {
            VStack {
                /// AsyncImage allows us to load image in async manner
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    /// We can add modifier to an aysnc image only after its added, one of the call definitision of asyncImage also allows us to check phases in which image download is.
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                Button("Checkout") {
                    /// Inside a button to run an async function we need to use Task {} closure.
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thankyou", isPresented: $showAlertMessage) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }
    }
    
    // Making HTTP request in SWift
    func placeOrder() async {
        /// 1. Encode the data
        guard let encodedData = try? JSONEncoder().encode(order) else {
            print("Unable to encode order")
            return
        }
        
        /// 2. Create URL Request
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            /// 3. Start URL session and do a POST or GET. Here we are doing POST request.
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
            showAlertMessage = true
            let decodedData = try JSONDecoder().decode(Order.self, from: data)
            alertMessage = "Your order for \(decodedData.quantity) cupcakes is done."
        } catch {
            print("Checkout Failed")
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
