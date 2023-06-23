//: [Previous](@previous)

import Foundation

// +---------------+---------------------+---------------------------+
// |    Type       |  Number of Elements |     Allowed Types         |
// +---------------+---------------------+---------------------------+
// |    Array      |  Multiple (Ordered) |  Elements of the same type|
// +---------------+---------------------+---------------------------+
// |    Set        | Multiple (Unordered)|  Elements of the same type| (No duplication) | (Fast access as they are based on dictionaries)
// +---------------+---------------------+---------------------------+
// |    Tuple      |Fixed-size (Ordered) |Elements of different types| (Type and size need to be defined on initialisation)
// +---------------+---------------------+---------------------------+


// 2. Tuples are the go-to way for returning multiple values in function - 1) they can be named and indexed, 2) they can be destructed, 3) unlike dictionaries you don't have to use ?? to provide default values

func getUserInfo() -> (name: String, age: Int, isAdmin: Bool) {
    let name = "John Doe"
    let age = 30
    let isAdmin = true
    return (name: name, age: age, isAdmin: isAdmin)
}

// 3. Destructuring example
let (name, age, isAdmin) = getUserInfo()
print(isAdmin)

// 4. Destructuring happens by index number, so we can use any variable name, also use _ if we don't need a particular value
let (name2, age2, _) = getUserInfo()
print(age2)

// 5. Values of tuples can be accessed by name or index.
let userInfo = getUserInfo()
print(userInfo.name)
print(userInfo.0)

