// Strings - "hello"

// Int - 12, 10

// Double – 0.4, 1.2

// Bool – true, false

var a:String = "this can change"
a = "world"
print(a)

let b:String = "this won't change"
// b = "change it" - This would cause an error.
print(b)

func myFunc(firstNumber a: Int, secondNumber b: Int = 0) -> Int {
    // 1. we can do optional parameters using =
    // 2. firstNumber and secondNumber are external parameter names and a and b are internal parameter names. So inside function you can continue using a and b, however while function is called users can use these labels to define parameters.
    return a + b
}

// 3. If there were no argument label you could have called the fucntion normally
// print(myFunc(a:1,b:2))

// optional paramter example
print(myFunc(firstNumber: 2, secondNumber: 4))

// argument label example
print(myFunc(firstNumber: 5))

func myFunc(_ a: Int, _ b: Int) -> Int {
    // 4. Using _ as argument label allows us to not mention a paramter at all while calling the function
    return a - b
}

// 4.5 When you have only one line in your function you do not need to use return statement
func myFuncX(_ a: Int, _ b: Int) -> Int {
    a - b
}

// Like other languages
// 5. Something super cool happening here, we have 2 myFunc functions, how is this possible. This is possible because the signature of them is different, the paramters on first myFunc and second myFunc are different
myFunc(1,2)

// 5. Function without any output type means it has void output type
func myFunc2() {
    // the expression for this function could be written as
    // func myFunc2() -> void {
    print("the return type of this function is void")
}

// 6. Comparing 2 strings using if a == b can be very slow, so try to find ways around it. For example
let name = "Sparsh"

// Slow
if name == "" {
    print("Anonymous")
}

// Slow
if name.count == 0 {
    print("Anonymous")
}

// fast because it quickly checks if a string is empty without going through the whole string which is problem with other options.
if name.isEmpty {
    print("Anonymous")
}

// 7. Switch Statement - there is no "break" required in swift, it just runs the matched case and exits the switch flow.
enum Sizes: Comparable {
    case small
    case medium
    case large
}

var size = Sizes.small

switch size {
case .small:
    print("small")
case .medium:
    print("medium")
case .large:
    print("large")
default:
    print("if no cases matches we get here.")
}
