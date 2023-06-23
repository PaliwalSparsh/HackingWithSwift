//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)


//Error handling takes three steps:
// 1. Telling Swift about the possible errors that can happen.
// 2. Writing a function that can flag up errors if they happen.
// 3. Calling that function, and handling any errors that might happen.

// 1.
enum PasswordError: Error {
    case short, obvious
}

// 2. you need to have throws in function definition and you should throw error inside the function
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }

    if password == "12345" {
        throw PasswordError.obvious
    }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

// 3. Executing function and catching errors, just use do...catch, use try to run the function that throws. Finally, if an error occurs it can be caught using specific PasswordError.short, PasswordError.obvious or the catch everything at the end.
let string = "12345"

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}

// 5. Tip: Most errors thrown by Apple provide a meaningful message that you can present to your user if needed. Swift makes this available using an error value that’s automatically provided inside your catch block, and it’s common to read error.localizedDescription to see exactly what happened.


