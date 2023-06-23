//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

// 1. Extensions let us add functionality to any type, whether we created it or someone else created it – even one of Apple’s own types. Extensions may not add new stored properties, only computed properties

// 2. In swift, the convention for naming things is as such, sort() means sort the array in-place and sorted() means return a sorted array.

extension String {
    
    func trimmed() -> String {
        // 3. Writing this big line everytime you want to trim is a lot of work so we created a extension trimmed() which is much easier to type.
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // 4. Here self = self.trimmed() main current instance completely replace ho ja raha hai by a new string returned by self.trimmed(), toh in-place hi change ho jaega apna string. Because now its a new string. Wohooooo!!!! smart.
    mutating func trim() {
        self = self.trimmed()
    }

}

var a = "Sparsh  "
var b = a.trimmed()
print(a)
// a.trim doesn't return anything so c will be empty, however a gets trim here :)
var c = a.trim()
print(a)
print(b)
print(c)


// 5. When to use extensions -
// Extensions are also useful for organizing our own code, and although there are several ways of doing this I want to focus on two here: conformance grouping and purpose grouping. a) Conformance grouping means adding a protocol conformance to a type as an extension, adding all the required methods inside that extension. This makes it easier to understand how much code a developer needs to keep in their head while reading an extension – if the current extension adds support for Printable, they won’t find printing methods mixed in with methods from other, unrelated protocols. b) On the other hand, purpose grouping means creating extensions to do specific tasks, which makes it easier to work with large types. For example, you might have an extension specifically to handle loading and saving of that type.

// It’s worth adding here that many folks realize they have a large class and try to make it smaller by splitting it into extensions. To be quite clear: the type is exactly the same size it was before, it’s just neatly split up. This does mean it’s likely to be a little easier to understand, but it doesn’t mean the class is any smaller.


