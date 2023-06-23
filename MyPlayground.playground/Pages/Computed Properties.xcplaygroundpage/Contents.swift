//: [Previous](@previous)

import Foundation


// 1. Computed Properties - are a blend of both stored properties and functions: they are accessed like stored properties, but work like functions

struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int {
        vacationAllocated - vacationTaken
    }
}

var a = Employee(name: "Sparsh")
a.vacationRemaining

// 2. Computed properties can have both getter and setter functions
struct Employee2 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        set {
            vacationAllocated = vacationTaken + newValue
        }
        
    }
}

var b = Employee2(name: "Sparsh")
b.vacationRemaining = 5
print(b.vacationRemaining)

