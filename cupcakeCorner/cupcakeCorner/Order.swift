//
//  Order.swift
//  cupcakeCorner
//
//  Created by Sparsh Paliwal on 8/29/23.
//

import Foundation

/// For a class which has @Published properties in it, we cannot just directly add Codable and expect
/// the class to be decoded and encoded automatically, instead we need to tell swift how the encoding and
/// decoding will happen
class Order: ObservableObject, Codable {
    
    /// We define the CodingKeys enum for use in encoding and decoding functions
    enum CodingKeys: CodingKey {
        case type, quantity, hasSprinkles, hasFrosting, name, street, city, zip
    }
    
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
    
    /// Through such computed properties we can introduce validations alongside data
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
    
    /// This is an empty init, in Swift a class can have multiple inits and class can be initialised using any of those inits.
    init() {}

    /// This init with decoder contains the strategy for how class will be decoded if needed. We start by creating a container
    /// and saying the container to be keyed by the enum CodingKeys. Then for each key we add value.
    /// Required in front of init means if some class inherits this class then it would need to create an override init function.
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        hasSprinkles = try container.decode(Bool.self, forKey: .hasSprinkles)
        hasFrosting = try container.decode(Bool.self, forKey: .hasFrosting)
        
        name = try container.decode(String.self, forKey: .name)
        street = try container.decode(String.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    /// Similar to decoder in the encode function we define how encoding should happen, we again create a container
    /// and tell how keys should be added.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(hasSprinkles, forKey: .hasSprinkles)
        try container.encode(hasFrosting, forKey: .hasFrosting)
        
        try container.encode(name, forKey: .name)
        try container.encode(street, forKey: .street)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
}
