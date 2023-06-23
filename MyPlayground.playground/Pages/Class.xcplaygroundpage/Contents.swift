// CLASS VS STRUCTS
//1. You can make one class build upon functionality in another class, gaining all its properties and methods as a starting point. If you want to selectively override some methods, you can do that too.
//2. Because of that first point, Swift won’t automatically generate a memberwise initializer for classes. This means you either need to write your own initializer, or assign default values to all your properties.
//3. ** When you copy an instance of a class, both copies share the same data – if you change one copy, the other one also changes.
//4. When the final copy of a class instance is destroyed, Swift can optionally run a special function called a deinitializer.
//5. ** Even if you make a class constant, you can still change its properties as long as they are variables. The reason for this lies in the fundamental difference between a class and a struct: one points to some data in memory, whereas the other is one value such as the number 5. If you have a let a = some Struct, you cannot change its parameters. Remember, a struct is a like other primitive datatypes a whole complete one thing, this is the reason we need MUTATING in struct for a func that can change properties but nothing like that is needed in a class -> https://www.hackingwithswift.com/quick-start/beginners/how-to-work-with-variables-inside-classes

// Bad thing about classes is that when you keep on inheriting for a long lenght let's say a class has 10 parents and grandparents and so on... Then think about the number of parameters in its initialisers also think of the number of properties in it. It would become super hard to handle them.


// ACCESS CONTROL
// All properties of person are inherited to Comedian except the ones marked private, also private can't be used by Persona itself outside its scope.

class Person {
    private var name = ""
    
    func talk() {
        print("I am talking!!")
    }
}

// OVERRIDE
class Comedian: Person {
    // 7. Override is used override the function of parent class. When is this actually useful -  if someone has designed a brilliant class that you want to use, but it isn’t quite right, wouldn’t it be nice to just override one part of its behavior rather than having to rewrite the whole thing yourself?
    override func talk() {
        print("Making people laugh")
        super.talk()
    }
}

var a = Person()
a.talk()

var c = Comedian()
print(c.talk)


// INITIALISERS

class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
}

class Developer: Employee {
    // If there is no init in a subclass, swift automatically inherits it from the parent class
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
}

class Manager: Employee {
    var title: String
    
    // Here we have a new property so we have to first define all prorpety of curretn function are intialised then call the intialiser of parent to ensure all its properties are initialised.
    init(title: String, hours: Int) {
        self.title = title
        // Super is used to refer to parent class, so here in this override function we are calling init of Employee
        super.init(hours: hours)
    }
    
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()


// HOW TO COPY A CLASS
class User {
    var username = "Anonymous"

    // We can creat a copy function like this to create a copy of the class. This is a trick to overcome the REFERENCE TYPE behaviour of class.
    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

var user1 = User()
var user2 = user1
user2.username = "Taylor"

print(user1.username)
print(user2.username)

// DEINITIALISERS
// its a method that gets called when a class is destroyed. Btw, class is destryoed only when all of the variables refrencing to it are destroyed.
// Behind the scenes Swift performs something called automatic reference counting, or ARC. ARC tracks how many copies of each class instance exists: every time you take a copy of a class instance Swift adds 1 to its reference count, and every time a copy is destroyed Swift subtracts 1 from its reference count. When the count reaches 0 it means no one refers to the class any more, and Swift will call its deinitializer and destroy the object.

class User {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    // it doesn't take any arguments nor does it return anything;.
    deinit {
        print("User \(id): I'm dead!")
    }
}



// 8. you can use final keyword if you don't want your class to never be inherited as a superclass. Usually add final to all classes you create until unless a need arises. Just ADD FINAL TO your classes
final class Animal {
    
}

// This would throw error
class Cat: Animal {
    
}


// 9. structs cannot have subclasses, the keywrod after colon in them is a protocol they conform to.
struct Cart: View {
    
}

// 10. However, classes can conform with protocol, just declare ti simialr to superclass
class Bird: View {
    
}

// 11. we can have both superclass and conformance to a protocol, you just need to separate them by a comma.
class Crow: Bird, View {
    
}
