//
//  Candy+CoreDataProperties.swift
//  CoreDataConceptsAdvanced
//
//  Created by Sparsh Paliwal on 9/20/23.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var country: Country?
    
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }


}

extension Candy : Identifiable {

}
