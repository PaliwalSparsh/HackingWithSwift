struct MyStructure {
    var message = "hello"
    func myFunction() {
        print(message)
    }
}

// 1. This is how we instantiate a struct
// 2. The datatype of structure is its own self. So, we could have intitialised this whole thing as var a:MyStructure = MyStructure()
var a = MyStructure()

// 3. Accessing properties of structure
a.message = "hi"
a.myFunction()

// 4. You can create any number of instances
var b = MyStructure()
b.message = "halo"
b.myFunction()

// 5. How can multiple structs interact
struct DatabaseManager {
    
    // 6. You won't be able access this variable outside this struct, you can do the same with a function
    private var serverName = "Server 1"
    
    func saveData(data:String) -> Bool {
        // this code saves data and returns bool
        return true
    }
}

struct sendChat {
    var message = ""
    func sendChat () {
        // 5 cont. We can call one struct in another one.
        var db = DatabaseManager()
        let isSuccessful = db.saveData(data: message)
        
        //... further operations
    }
}
