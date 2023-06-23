//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

// Property observer allow you to run code when a property value is changed in a struct.
struct App {
    var counter: Int = 0 {
        willSet {
            print("Current value is \(counter)")
            print("New value is \(newValue)")
        }
        
        didSet {
            print("New value is \(counter)")
            print("Preview value is \(oldValue)")
        }
    }
}

var a = App()
a.counter = 1
