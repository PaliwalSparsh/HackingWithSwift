//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

let names = ["A", "B", "C", "D"]

for name in names {
    print(name)
}

// 1. Swift will recognize you don’t actually need the variable, and won’t make the temporary constant for you, that's created usually when a constant is provided instead of _
for _ in 1...5 {
    print("using underscore as a placeholder")
}

// 2. For ranges you can also have one-sided ranges like 1... and ...3
print(names[1...3])
print(names[0...])
print(names[...3])

// 3. While loop is useful when you have to keep on looping until a condition is met.
var a = 0
while(a<4) {
    print("endless")
    a+=1
}

// 4. In swift you can use "break" to end all upcoming loops and "continue" to skip current loop
var numberArray: [Int] = []
for i in 1...100_00 {
    if i.isMultiple(of: 4) && i.isMultiple(of: 14) {
        numberArray.append(i)
    }
    if numberArray.count == 10 {
        break
    }
}

print(numberArray)
