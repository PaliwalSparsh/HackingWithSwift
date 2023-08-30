//
//  ContentView.swift
//  cupcakeCorner
//
//  Created by Sparsh Paliwal on 8/26/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Type of Cupcake", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) { index in
                            Text(Order.types[index])
                        }
                    }
                    Stepper("Quantity: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any Extra Requests?", isOn: $order.hasExtraRequest.animation())
                    if order.hasExtraRequest {
                        Toggle("Add extra sprinkles", isOn: $order.hasSprinkles)
                            .transition(.slide)
                        Toggle("Add extra frosting", isOn: $order.hasFrosting)
                            .transition(.slide)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Checkout")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
