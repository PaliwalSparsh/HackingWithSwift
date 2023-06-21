

## Why does SwiftUI use struct for views instead of classes?
1. Easy to think about: Structs hold very little data. For example Color.red and LinearGradient as views – trivial types hold very little data. However, all UIKit views inherited from UIView class this class itself contained hundereds of properties making each view complex to think about as programmer.
2. Functional approach for UI rendering: SwiftUI's views are a function of their state. Struct help to achieve functional programming, you enter values of a state into a struct and you get a new struct, when the value of state changes you again get a new struct. A basic diffiing tells that View changed and UI needs to be updated. (Somewhat similar to React)
3. Faster: Struct are also faster than class because they are simpler.

## How do modifiers work in SwiftUI?
```
Button("Hello, world!") {
    print(type(of: self.body))
}    
.background(.red)
.frame(width: 200, height: 200)
```
This returns `ModifiedContent<ModifiedContent<Button<Text>, _BackgroundStyleModifier<Color>>, _FrameLayout>`. 

Every time we modify a view SwiftUI applies that modifier by using generics: ModifiedContent<OurThing, OurModifier>. Clearly the order of modifiers matter.

We use `type(of: self.body)` because all swift views have a compulsory body property and we want to know its type.

## Why does SwiftUI use “some View” for its view type?
1. Returning some View means even though we don’t know what view type is going back, the compiler does. That might sound small, but it has important implications. Swift needs to know the type of Views so it can track struct for changes. When we say "some" we ask swift to figure out type of view by itself.
2. Technically, some View can be replaced by a type value such as `ModifiedContent<ModifiedContent<Button<Text>, _BackgroundStyleModifier<Color>>, _FrameLayout>`. However, this gets complicated with other kinds of Views such as VStack which are maintained as tupleViews `TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)>`. So, it's better we let SwiftUI decide what's the type of view internally by telling it some view.


