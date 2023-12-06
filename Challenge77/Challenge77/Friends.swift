//
//  ContentView-ViewModel.swift
//  Challenge77
//
//  Created by Sparsh Paliwal on 12/6/23.
//

import Foundation

struct Friend: Identifiable, Equatable, Comparable, Codable {
    var id: UUID = UUID()
    var name: String
    var imageId: String = UUID().uuidString
    
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.name < rhs.name
    }
}

class Friends: ObservableObject {
    @Published var list: [Friend] {
        didSet {
            do {
                let data = try JSONEncoder().encode(list)
                try data.write(to: Friends.path)
            } catch {
                print("not able to write data")
            }
        }
    }
    
    init() {
        do {
            let data = try Data(contentsOf: Friends.path)
            let listData = try JSONDecoder().decode([Friend].self, from: data)
            self.list = listData
        } catch {
            print("not able to get data")
            self.list = []
        }
    }
    
    static let path = FileManager.documentsDirectory.appendingPathComponent("friends")
}
