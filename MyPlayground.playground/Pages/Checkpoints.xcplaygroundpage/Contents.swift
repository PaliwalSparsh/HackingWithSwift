import Foundation

// Checkpoint 2

let artist:[String] = ["Ed sheeran", "Eminem", "Arijit", "Taylor", "Eminem", "Taylor"]

print(artist.count)

// 1. Array can be converted in sets by this easy method.
var uniqueArtist = Set(artist)

print(uniqueArtist.count)



let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

luckyNumbers.filter { !$0.isMultiple(of: 2) }.sorted().map { "\($0) is a lucky number" }.forEach { print($0) }


let a: String = String()
print(a)

// Struct

struct Car {
    let model: String
    let seats: Int
    private var gear: Int = 0
    var currentGear: Int {
        get {
            gear
        }
        set {
            if newValue > 10 {
                gear = 10
            } else if newValue < 1 {
                gear = 1
            } else {
                gear = newValue
            }
        }
    }
    
    init(model: String, seats: Int) {
        self.model = model
        self.seats = seats
    }
}

var sonata = Car(model: "2019", seats: 4)
print(sonata.currentGear)
sonata.currentGear = 16
print(sonata.currentGear)

// Class
class Animal {
    let legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak(words: String = "") {
        print("wo wo wo \(words)")
    }
}

class Corgi: Dog {

}

class Poodle: Dog {}

class Cat: Animal {
    var isTame: Bool
    init(isTame: Bool, legs: Int) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak(words: String = "") {
        print("meow meow \(words)")
    }
}

class Persian: Cat {
    func speak() {
        super.speak(words: "in Persian")
    }
}

class Lion: Cat {
    func speak() {
        super.speak(words: "in Lion")
    }
}

var someLion = Lion(isTame: true, legs: 4)
someLion.speak()

// Checkpoint 8

protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var agent: String { get set }
    func salesSummary() -> Void
}

struct House: Building {
    let rooms: Int
    let cost: Int
    var agent: String
    
    func salesSummary() {
        print("Summary is \(rooms * cost)")
    }
}

struct Office: Building {
    let rooms: Int
    let cost: Int
    var agent: String
    
    func salesSummary() {
        print("Summary is \(rooms * cost)")
    }
}

let newport = House(rooms: 100, cost: 200_000, agent: "Sparsh")
newport.salesSummary()


// Checkpoint 9
func randomNumberFromList(list: [Int]?) -> Int {
    list?.randomElement() ?? Int.random(in: 1...100)
}

print(randomNumberFromList(list: [1,2,3]))
print(randomNumberFromList(list:[]))
print(randomNumberFromList(list: nil))

/// struct experiments

struct Airpods {
    var battery: Int

    mutating func drainBattery(by drainBatteryValue: Int) {
        battery = battery - drainBatteryValue
    }
}

var sparshPods = Airpods(battery: 87)
sparshPods.drainBattery(by: 10)

let a1 = 0.0
print("Here is ", a1.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
