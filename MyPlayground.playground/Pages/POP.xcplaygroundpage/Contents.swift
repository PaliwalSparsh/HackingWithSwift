//: [Previous](@previous)
// PROTOCOL EXTENSIONS

import Foundation

// 1. Protocol extensions let us add functionality to many types all at once – we can add properties and methods to a protocol, and all conforming types get access to them. Instead of just providing this property on the Array type, we can provide it on the protocol Collection which is followed by Array, Dictionary, Sets in Swift. And it would now work with all of those.
// extension Array {
extension Collection {
    var isNotEmpty: Bool {
        self.isEmpty == false
    }
}

var array = [1,2,3]
print(array.isNotEmpty)

// 2. This is called Protocol Oriented Programming or POP. We can list some required methods in a protocol, then add default implementations of those inside a protocol extension. All conforming types then get to use those default implementations, or provide their own as needed.

protocol Person {
    var name: String { get }
    func sayHello()
}

extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

// Here just conforming to Equatable gave access to == without writing anything, this is amazing. So, Equatable protocol already had a implemented extension similar to sayhello above and out of the box, it just compares all values of two structs and tells if they are similar or not. https://www.hackingwithswift.com/quick-start/beginners/how-to-get-the-most-from-protocol-extensions
struct Employee: Person, Equatable {
    let name: String
}

let taylor = Employee(name: "Taylor Swift")
let swift = Employee(name: "Taylor Swift")
taylor.sayHello()
print(taylor == swift)
