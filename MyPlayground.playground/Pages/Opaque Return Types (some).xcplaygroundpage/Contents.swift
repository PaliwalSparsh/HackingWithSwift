//: [Previous](@previous)

import Foundation

// TLDR; Opaque return types let us hide some information in our code. That might mean we want to retain flexibility to change in the future, but also means we don’t need to write out gigantic return types.


// 0. Opaque return types in Swift allow us to hide specific information about the types we return from functions while still letting the Swift compiler understand their actual types. This is useful because it allows us to focus on the functionality of the returned values rather than their specific types, providing flexibility and abstraction.

// 1. For example, imagine we have functions that return random numbers and random booleans. Both Int and Bool types conform to the Equatable protocol, which means they can be compared using ==. Initially, we might try to make the functions return Equatable to indicate that the values they return can be compared. However, this doesn't work because Equatable cannot be used as a return type directly. The reason is that even though Int and Bool conform to Equatable, they are not interchangeable types. We cannot compare an Int and a Bool using ==. To solve this problem, we can use opaque return types by adding the keyword some before the return type:


func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

// 2. Now, we can call getRandomNumber() multiple times and compare the results using ==. The opaque return type allows us to hide the exact type of the returned values while letting the Swift compiler understand their underlying types.

var a = getRandomNumber()
var b = getRandomNumber()
var c = getRandomBool()

print(a)


// Garib explanation: Yahan pe 2 which is Int and 1.0 which is double both conform to Numeric protocol. Toh hume nai bolna compiler ko ki kaunsa return value jaega for 2 reasons a) humko khud nai pata kya jaega, b) similar to some Views, itna bada return value likhna bht takleef dayak ho jaega. So what we do we tell compiler it is some type of Numeric value.
func getSomeNumeric() -> some Numeric {
    Bool.random() ? 2 : 1.0
}

// Jab tum getSomeNumeric karke . press karoge toh it will show you just methods of Numeric protocol, hamare liye opaque hai ki andar kaunsa type hai getSomeNumeric ke, but yeh maloom hai ki kisi type ka Numeric hai toh kuch nai toh Numeric ke methods toh use kar hi sakta hun.
print(getSomeNumeric().magnitude)

// print(2.hashValue)
// print(getSomeNumeric().hashValue)
      

