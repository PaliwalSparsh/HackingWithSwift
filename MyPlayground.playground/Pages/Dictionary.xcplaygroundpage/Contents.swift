var a:[String: String] = [String:String]()

a["J200"] = "Sparsh"

// 1. The output is Optional("Sparsh"). When you try to fetch value out of dictionary, you are given an optional because if the key provided is random a["adsfa"], the output would be nil, so dictionaries, give us optional output and we have to unwrap to use them.
print(a["J200"])

// 2. Output of this would be nil
print(a["J101"])

// 3. Remove an itme
a["J200"] = nil

// 4. Declaring a dictionary
var b = ["a": 1, "n": 2]

// 5. Iterating through dictionary
for keyValuePair in b {
    print("key is", keyValuePair.key)
    print("Value is", keyValuePair.value)
}

// 6. keyValuePair is a tuple (essentailly an array whose elements can be of different datatypes), so we can also destructure and use it like this
for (key, value) in b {
    print("key is", key)
    print("Value is", value)
}

// 7. Tuple example
var k:(String, String) = ("Hey1", "Hey2")
