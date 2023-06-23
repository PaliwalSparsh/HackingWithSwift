//: [Previous](@previous)

// 0. IMPORTANT: Static type belong to the type itself and not to any of its instance. When compiler goes through a Class/Struct code it first initialised all normal (also called instance) variable and properties, then initialised the static properties. And because static variable and methods are initialised later we can use the class itself in them(as you will see below). Often instance variables, are provided default value using static properties this is also made possible because static properties are already executed and when an object is created that static value is passed to the variable. So order is –> Instance Variable and propeties -> Static variable and properties [At this point we are ready in case someone needs to create an object from class/struct] -> Object creation.


import Foundation

var greeting = "Hello, playground"

// 1. [RARELY USED] static keyword - you want to add a property or method to the struct itself, rather than to one particular instance of the struct, which allows you to use them directly.
// 2. [TWO USE CASES] I use this technique a lot with SwiftUI for two things: creating example data, and storing fixed data that needs to be accessed in various places.
// Usecase 1: Storing data
struct AppData {
    static let appName = "stayInTouch"
    static let version = "v1.0.2"
    static let url = "stayintouch.com"
}

print(AppData.appName)

// Usecase 2: creating example data. This is crazy good as all code for example is contained in this struct only.
struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfederighi", password: "hairforceone")
}

print(Employee.example.username)


// 3. If you want to mix and match static and non-static properties and methods, there are two rules:
// 1) To access non-static code from static code… you’re out of luck: static properties and methods can’t refer to non-static properties and methods because it just doesn’t make sense – which instance of School would you be referring to?
// 2) To access static code from non-static code, always use your type’s name such as School.studentCount. You can also use Self to refer to the current type.
// Now we have self and Self, and they mean different things: self refers to the current value of the struct, and Self refers to the current type.

// Tip: It’s easy to forget the difference between self and Self, but if you think about it it’s just like the rest of Swift’s naming – we start all our data types with a capital letter (Int, Double, Bool, etc), so it makes sense for Self to start with a capital letter too.

struct NewsStory {
    static var breakingNewsCount = 0
    static var regularNewsCount = 0
    var headline: String
    init(headline: String, isBreaking: Bool) {
        self.headline = headline
        if isBreaking {
            NewsStory.breakingNewsCount += 1
        } else {
            NewsStory.regularNewsCount += 1
        }
    }
}

// Personal: Static methods can be used to keep a count of how many instances of a struct are created
print(NewsStory.breakingNewsCount)
print(NewsStory(headline: "yo", isBreaking: true))
print(NewsStory.breakingNewsCount)


struct Pokemon {
    static var numberCaught = 0
    var name: String
    static func catchPokemon() {
        print("Caught!")
        // This static property can be called as Pokemon.numberCaught, just numberCaught or Self.numberCaught
        numberCaught += 1
    }
}

print(Pokemon.numberCaught)
