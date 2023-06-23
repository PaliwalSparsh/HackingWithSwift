// Optinals are swifts way of handling null values. Which have historically created a lot of issues in programming.

// 4. OPTIONALS (Birthday gift, you need to unwrap to use)----
// Can contain nil
// Xcode warn us
// Need to unwrap before using

var c:Int? = 2

// UNWRAPPING 1: Using an if statement to check if its not nill
if c != nil {
   var x = 2 + c!
}

// UNWRAPPING 2: Optional binding, this is alternative of last technique, here we copy value of c to y, if c is nil, y is nil and thus if won't execute, however, if c is not nil thus y is not nil, you go inside the execution block where addition would take place, now because we already passed value of c to y, we would not need to unwrap c using !
if let y = c {
    var x = 1 + y
}

// Often in swift code you will see people just use same name of variable during unwrapping as the original variable. The scope of newly created c is anyway different
if let c = c {
    var x = 1 + c
}

struct Person {
    var name = ""
    
    func talk() {}
}

var sparsh:Person?

// When we unwrap using !, it will throw error
sparsh!.talk()

// So we will instead use optional chaining here, if sparsh is not nil then run the talk function.
sparsh?.talk()

var myVar: Int? = 3

// UNWRAPPING 3: GUARD (VS IF LET)

// if let unwrapped = myVar {
//     Run if myVar has a value inside
// }
//
// guard let unwrapped = myVar else {
//     Run if myVar doesn't have a value inside
// }

// GUARD IS USEFUL FOR EARLY RETURN STYLE OF PROGRAMMING
// guard is designed exactly for this style of programming, and in fact does two things to help: 1. If you use guard to check a function’s inputs are valid, Swift will always require you to use return if the check fails. 2. If the check passes and the optional you’re unwrapping has a value inside, you can use it after the guard code finishes.

func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")

        // 1: We *must* exit the function here
        return
    }

    // 2: `number` is still available outside of `guard`
    print("\(number) x \(number) is \(number * number)")
}

// So: use if let to unwrap optionals so you can process them somehow, and use guard let to ensure optionals have something inside them and exit otherwise.

// It’s common to see guard used one or more times at the start of methods, because it’s used to verify some conditions are correct up front. Guard lets us focus on the “happy path” – the behavior of our function when everything has gone to plan, which is to print the meaning of life. 

// UNWRAPPING 4: NIL COALESCING var author = authorname ?? "N/A"

// UNWRAPPING 5:
// ** if any method in optional chaining returns nil, whole thing returns nil.

struct Book {
    let title: String
    let author: String?
}

var book: Book? = nil
// Optional chaining makes for a very good companion to nil coalescing, because it allows you to dig through layers of optionals while also providing a sensible fall back if any of the optionals are nil.
let author = book?.author?.first?.uppercased() ?? "A"
print(author)

// UNWRAPPING 6: HANDLING FUNCTION FAILURE

enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

// try? returns nil if function throws error
if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

/// OR

let user = (try? getUser(id: 23)) ?? "Anonymous"

