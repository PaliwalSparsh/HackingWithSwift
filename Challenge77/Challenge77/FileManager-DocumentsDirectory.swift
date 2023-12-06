//
//  FileManager-DocumentsDirectory.swift
//  Challenge77
//
//  Created by Sparsh Paliwal on 12/6/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
