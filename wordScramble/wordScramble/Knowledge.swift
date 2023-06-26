//
//  Knowledge.swift
//  wordScramble
//
//  Created by Sparsh Paliwal on 6/24/23.
//

import SwiftUI



struct Knowledge: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    /// 1. Xcode puts together all files such as code(after comilation), images, text, xml and json files together, this is called as a bundle. Later we will see, we can actually include multiple bundles in a single app, allowing us to write things like Siri extensions, iMessage apps, widgets, and more, all inside a single iOS app bundle. Although these get included with our app’s download from the App Store, these other bundles are stored separately from our main app bundle.
    /// 2. While writing code, its common to look in a bundle for a file you placed there. This uses URL data type, in URL you can store location of files(similar to web addresses). If we want to read the URL for a file in our main app bundle, we use Bundle.main.url()
    func getFile() {
        /// 3. First we search a file in our app bundle. Now, it can be there or it cannot be there, therefore it returns an optional URL, thus if let.
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            
            /// 4. Next we use String(contentsOf: ) to read content of a file, now again there can be issue while reading the file, so this function throws, so we use try? here, so if String(contentsOf: ) will throw it will convert it into a nil and if let won't execute.
            if let fileContents = try? String(contentsOf: fileURL) {
                // we loaded the file into a string!
            }
        }
    }
}

struct Knowledge_Previews: PreviewProvider {
    static var previews: some View {
        Knowledge()
    }
}
