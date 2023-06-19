//
//  MultipleAlertTestView.swift
//  flagGame
//
//  Created by Sparsh Paliwal on 6/19/23.
//

import SwiftUI

struct MultipleAlertTestView: View {
    @State private var showAlert1 = false
    @State private var showAlert2 = false
    var body: some View {
        /// 1. If multiple alerts are attached to a view, both will get triggered :)
        /// 2. Similar to ZStack the one in the bottom goes first and then the one above it goes second.
        Button("show alert") {
            showAlert1 = true
            showAlert2 = true
        }
        .alert("Alert 2", isPresented: $showAlert2, actions: {})
        .alert("Alert 1", isPresented: $showAlert1, actions: {})
    }
}

struct MultipleAlertTestView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleAlertTestView()
    }
}
