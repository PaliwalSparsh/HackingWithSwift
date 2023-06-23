//: [Previous](@previous)

import Foundation

func greetUserFunc(name: String) {
    print("hello \(name)")
}

// 1. A closure is a chunk of code we can pass around and call whenever we want. It's same as a function, however the way its written is different we write it inside {...} and seperate parameters and code with "in"
var greetUserClosure = { (name: String) -> Void in
    print("hello \(name)")
}

greetUserFunc(name: "Sparsh")
// 2. While calling a closure, you don't have to write parameter. Here there is no need to write "name"
greetUserClosure("Purbita")

// 3. The benefit of closure is that it can be used in place. Unlike a function which we have to first declare adn then use.

// 3a. using a function
func captainFirstSortedFunc(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}

var users = ["Suzanne", "Gloria", "Piper", "Tasha", "Tiffany"]
print(users.sorted(by: captainFirstSortedFunc))

// 3b. using a closure.
print(users.sorted(by: {(name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    return name1 < name2
}))

// 4. closure shorthand syntax - swift takes writing shorthand with closure to the next step

// 4a. Because swift knows what kind of function is expected by ".sorted(by: " we can remove parameter types and return type

print(users.sorted(by: {(name1, name2) in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    return name1 < name2
}))

// 4b. further swift says why give two parameters names instead use something which i already provide

print(users.sorted(by: {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    return $0 < $1
}))

// 4c. Next swift says why even use by: parameter, i know what .sorted expects as argument
print(users.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    return $0 < $1
})

// 4d. Next, if it's a oneline closure we don't even need to write return in it.
let tOnly = users.filter { $0.hasPrefix("T") }
print(tOnly)

// 5. How to accept functions as parameters in swift
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}

// 6 Advanced - closure capture value of their surrounding. In this example, the makeIncrementer function returns a closure of type () -> Int. This closure captures the total variable from its surrounding context and increments it by the incrementAmount value each time it is called. The incrementByTwo constant is assigned the returned closure from makeIncrementer(2), which effectively "remembers" the captured total variable.

When incrementByTwo() is called, it executes the closure and returns the incremented value. Each subsequent call to incrementByTwo() continues to increment the captured total variable by 2 and returns the updated value.

Closures are powerful tools in Swift that allow for flexible and concise code, especially when working with higher-order functions or asynchronous operations. They provide a way to encapsulate behavior and capture the necessary state to execute that behavior, even when the surrounding context changes or goes out of scope.






func makeIncrementer(incrementAmount: Int) -> () -> Int {
    var total = 0

    let incrementer: () -> Int = {
        total += incrementAmount
        return total
    }

    return incrementer
}

let incrementByTwo = makeIncrementer(incrementAmount: 2)

print(incrementByTwo()) // Output: 2
print(incrementByTwo()) // Output: 4
print(incrementByTwo()) // Output: 6


