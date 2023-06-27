//
//  ContentView.swift
//  wordScramble
//
//  Created by Sparsh Paliwal on 6/23/23.
//

import SwiftUI

struct ContentView: View {
    @State private var wordList = [String]()
    @State private var masterWord = ""
    @State private var currentWord = ""
    
    @State private var errorTitle = ""
    @State private var showErrorAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter current word", text: $currentWord)
                        .textInputAutocapitalization(.never)
                }
                Section("Your score is \(wordList.reduce(0) { $0 + $1.count })") {
                    List(wordList, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(masterWord)
            /// 1. On Submit allows us to tell the action that gets executed when user presses "Enter" on keyboard or on mobile keyboard, we can put onSubmit modifier to any view on the screen.
            .onSubmit(addWord)
            /// 2. On Appear runs when the first time we run the app.
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showErrorAlert) {
                Button("OK") {}
            }
            .toolbar {
                Button("Restart", action: startGame)
            }
        }
    }
    
    func addWord() {
        let answer = currentWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        /// 3. This is a great example of how we can use guard to check things at the top of a function and if they don't work just return
        guard answer.count > 0 else { return }
        guard isOriginal(word: answer) else {
            showError(title: "This word is already present")
            return
        }
        guard isPossible(word: answer) else {
            showError(title: "This is not possible using the letters of master word")
            return
        }
        guard isMeaningful(word: answer) else {
            showError(title: "This is not even a word, bro!!!")
            return
        }
        guard isCreative(word: answer) else {
            showError(title: "Increase number of letters & don't use the same master word")
            return
        }
        withAnimation {
            wordList.insert(answer, at: 0)
        }
        currentWord = ""
    }
    
    func startGame() {
        if let wordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let words = try? String(contentsOf: wordsURL) {
                let allWords = words.components(separatedBy: "\n")
                masterWord = allWords.randomElement() ?? "Silkworm"
                wordList = [String]()
                currentWord = ""
                return
            }
        }
        
        /// 4. This error can be used to crash the whole app, here in the case start.txt is not loaded the whole app is crashed :(
        fatalError("Start.txt file is not being loaded.")
    }
    
    func isCreative(word: String) -> Bool {
        word.count > 3 && word != masterWord
    }
    
    func showError(title: String) {
        showErrorAlert = true
        errorTitle = title
    }
    
    func isMeaningful(word: String) -> Bool  {
        /// 5. This is our first taste of using old UIKit functions inside SwiftUI.
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf8.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isPossible(word: String) -> Bool  {
        var temp = masterWord
        for l in word {
            /// 6. firstIndex returns nil if there is no item is present, so we can use if let here :)
            if let index = temp.firstIndex(of: l) {
                temp.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        !wordList.contains(word)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
