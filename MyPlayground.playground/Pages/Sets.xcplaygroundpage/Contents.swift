//: [Previous](@previous)

import Foundation

// Sets don't have an order, they can't have duplicate, however they are super fast at lookup. Arrays vs Sets – Because sets don’t need to store your objects in the order you add them(like arrays), they can instead store them in a seemingly random order that optimizes them for fast retrieval.
var actors = Set<String>()
actors.insert("SRK")
actors.insert("Salman")
actors.insert("Munna bhai")
