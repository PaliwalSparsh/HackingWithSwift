//
//  Order.swift
//  cupcakeCorner
//
//  Created by Sparsh Paliwal on 8/29/23.
//

import Foundation

class Order: ObservableObject {
    static let types = ["Strawberry", "Mango", "Rainbow", "Chocolate"]
    
    @Published var quantity = 3
    @Published var type = 0
    @Published var hasExtraRequest = false {
        didSet {
            if !hasExtraRequest {
                hasSprinkles = false
                hasFrosting = false
            }
        }
    }
    @Published var hasSprinkles = false
    @Published var hasFrosting = false
    
    @Published var name = ""
    @Published var street = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if(name.isEmpty || street.isEmpty || city.isEmpty || zip.isEmpty) {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost: Double = 2 * Double(quantity)
        if hasFrosting {
            cost += Double(quantity)
        }
        if hasSprinkles {
            cost += Double(quantity) * 0.5
        }
        return cost
    }
}
