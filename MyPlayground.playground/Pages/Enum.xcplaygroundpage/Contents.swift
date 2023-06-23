import Foundation

// 1. this is how we create enums
enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

// 2. this is shorthand for enums
enum Weekend {
    case saturday, sunday
}

// 3. Once we provide enum as initial value to a variable, we can just use .friday, .tuesday to define values, because now it knows the type assigned to the variable.
var day = Weekday.monday
day = .friday

// 4. Even enums are comparable in swift
enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large
print(first < second)



//
//class Person {
//    var id = UUID()
//    var name: String;
//    init(name: String) {
//        self.name = name
//    }
//}
//
//class Artist: Person {
//    var famousPainting: String;
//    var artistID: UUID
//    init(name:String, famousPainting: String) {
//        self.artistID = UUID()
//        self.famousPainting = famousPainting
//        super.init(name: name)
//    }
//}
//
//var sparsh = Artist(name: "Sparsh", famousPainting: "MonaLisa")
//var abhya = Person(name: "Abhay")
//
//print(sparsh.id)
//print(abhya.id)
//print(sparsh.artistID)

//print(Double(12.345).rounded(.towardZero))
