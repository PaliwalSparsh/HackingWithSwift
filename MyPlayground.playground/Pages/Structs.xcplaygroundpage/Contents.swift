// 1. Swift’s structs let us create our own custom, complex data types, complete with their own variables and their own functions.


// 2. Mutating Keyword - It’s possible to modify the properties of a struct, but only if that struct is created as a variable. Of course, inside your struct there’s no way of telling whether you’ll be working with a variable struct or a constant struct, so Swift has a simple solution: any time a struct’s method tries to change any properties, you must mark it as mutating. Why ? It's answered in next point
struct Employee {
    let name: String
    var vacationRemaining: Int

    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

// 3. mutating tells swift that this function can change a property of this struct. Why is this important? Because when we will create a constant from this struct using "let". And then try to execute take vacation on it, swift knows this will change a constant and swift type checking will stop us from performing this action.

let a = Employee(name: "Sparsh", vacationRemaining: 4)
// a.takeVacation(days: 4) This will throw error


// 4. When we create a struct, swift silently adds a init(initializer) function to the struct (syntatic sugar) that is used to create instance of that struct. This init function is present in all datatypes in swift and due to syntatic sugar we don't see them.
let b = Employee.init(name: "Abhay", vacationRemaining: 2)
let c = Double.init(2) // This is same as Double(2)

// 5. Custom initialiser in swift. You can create your own initialiser by using init but as soon as you do it. You no longer have access to swifts own member-wise intialiser. ONLY RULE FOR CUSTOM INIT IS THAT BY THE TIME ITS EXECUTION ENDS ALL PROPERTIES IN STRUCT SHOULD HAVE A VALUE.
struct Player {
    let name: String
    let number: Int

    // 6. You can have multiple init functions with different definitions to initialise function.
    init(name: String) {
        // IMPORTANT: we use self.name here only because we cannot do name = name. We use self to just say it's the name property of this struct and it is being assigned the name parameter of init function. This can be made clear in the next line where number is also a property of struct but we don't need a self to define it, because there's no namespace conflict. So self is used to clarify namespace conflict. - https://www.hackingwithswift.com/quick-start/understanding-swift/when-would-you-use-self-in-a-method
        self.name = name
        number = Int.random(in: 1...99)
    }
}

let player = Player(name: "Megan R")
print(player.number)

// 7. access control
// private - no one outside struct can set or get it.
// private(set) - no one outside struct can set it. However, they can get it.
// fileprivate - no on outside current file can set or get this variable.
// public - it's available to all
//
// access control is essential in defining surface area of a API, we learned about this concept in the software engineering book on writing code, we want to surface only a part of our API and not anything else and we should be intentional on what should be surfaced.

// 8. If you have a private property YOU WILL HAVE TO CREATE YOUR CUSTOM INIT FUCNTION, the memberwise default init by swift no longer works.
struct Fun {
    var a: Int = 1
    var b: Int
    private var c: Int = 3
    
    init(b: Int) {
        self.b = b
    }
}

var d = Fun(b: 2)

// n. Usually this is how structs in SwiftUI framework look
struct ChatView {
    
    // Properties
    var messsage:String = ""
    
    // View code for this screen
    
    // Methods
    func sendChat() {
        // Code to send the chat message
    }
}
