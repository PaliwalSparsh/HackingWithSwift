//
//  Card.swift
//  Filezilla_flashcard
//
//  Created by Sparsh Paliwal on 12/12/23.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who is PM of India?", answer: "Modi")
}
