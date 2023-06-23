//: [Previous](@previous)

import Foundation

// 1. Protocol allow us to setup a blueprint, that a class or struct has to follow, we just need to define - 1) Properties and if they are getable and setable, 2) the function definition of the methods.
protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { set get }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

// 2. Here we have created two structs Car and Bicycle both conform to Vehicle
struct Car: Vehicle {
    let name = "Car"
    var currentPassengers = 1

    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    // 3. Structs conforming to protocol can have additional methods ands properties
    func openSunroof() {
        print("It's a nice day!")
    }
}

struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassengers = 1

    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

// 4. The benefit of using protocol is that now we can write a function that can take in both Car and bicycle as a type because these both conform to Vehicle type. Swift knows that both Car and Bicycle will have function requried by Vehicle type. A real world example of this is Animatable, all Double, Int, Path etc. conform to Animatable, thus they all have animatableData { get set } property , because they have this property. Swift is able to animate these things. Without knowing what underlying type is, it only cares if our type is conforming to Animatable.

// 5. TLDR; protocols let us create blueprints of how our types share functionality, then use those blueprints in our functions to let them work on a wider variety of data
func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let bike = Bicycle()
commute(distance: 50, using: bike)

let car = Car()
commute(distance: 100, using: car)
