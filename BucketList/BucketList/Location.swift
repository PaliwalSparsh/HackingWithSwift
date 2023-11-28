//
//  Location.swift
//  BucketList
//
//  Created by Sparsh Paliwal on 11/28/23.
//

import Foundation
import MapKit

struct Location: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let longitude: Double
    let latitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    /// Try and always include an example in your struct is super helpful for previewing.
    static let example = Location(id: UUID(), name: "London", description: "Capital of England", longitude: 50, latitude: 0)
    
    /// By default Equatable would have compared all properties to ensure if two locations are same or not but here, we just tell hey, there's a better way just compare ids. For comparable we can have simlar static func >(lhs: Location), this form of operator overloading is pretty common.
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
