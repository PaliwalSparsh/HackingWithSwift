// 1. Type is automatically inferred - var myArray: [String] = ["a", "b", "c"]
var myArray = ["a", "b", "c"]

// 2. Add at end
myArray.append("d")

print(myArray)
print(myArray[2])

// 3. Change value at an index
myArray[1] = "z"

// See what this does
myArray.insert("l", at: 3)

// 4. There are multiple remove options
myArray.remove(at: 3)

// 5. Initialising empty array, on the right hand side we say there is a type [Int] and we want to intantiate it, so we use (). Other way of initialising is Array<Int>()
var emptyArray = [Int]()

// 6. Cool methods to use, myArray.sort(), myArray.reverse(), myArray.shuffle(), myArray.randomElement(), myArray.first(), myArray.last(),

// 6.5 reverse reverses in place, however reversed() doesn't reverse immediately but says ki whenever this will be used i will reversed it in the future.
// let a = myArray.reverse()
// print("The reversed array is", myArray)

// 7. contains
print(myArray.contains("a"))

// 8. firstIndex
print(myArray.firstIndex(of: "l"))

// --LOOP--

// 10. normal loop through numbers
for index in 1...10 {
    print(index)
}

// 9. We can use _ here because we are not using index
for _ in myArray {
    print("hello")
}

// 10. while & repeat while loop differ in how many times the condition is checked.
var counter = 10

repeat {
    print(counter)
    counter -= 1
} while counter > 0

while counter > 0 {
    print(counter)
    counter -= 1
}
