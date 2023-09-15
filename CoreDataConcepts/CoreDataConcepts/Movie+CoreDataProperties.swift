//
//  Movie+CoreDataProperties.swift
//  CoreDataConcepts
//
//  Created by Sparsh Paliwal on 9/14/23.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    
    /// Don't touch properties above this, as it's all managed by swift however you can add compouted properties like the one we did below, now we won't need to unwrap variables each time using title.
    public var wrappedTitle: String {
        title ?? "Unknown title"
    }

}

extension Movie : Identifiable {

}
