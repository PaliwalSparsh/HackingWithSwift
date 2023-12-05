//
//  ContentView.swift
//  BucketList
//
//  Created by Sparsh Paliwal on 11/25/23.
//

import MapKit
import SwiftUI

// Find load and decode
// Comparable for adding sorting to any type
// storing data in documents (sandbox for apps)
// using enums for showing varied states

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            if (viewModel.isUnlocked) {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) {
                    location in
                    /// if you don't want to create your own annotation just use MapMarker.
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.red.gradient)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                        }
                        .onTapGesture {
                            viewModel.selectedLocation = location
                        }
                    }
                }.ignoresSafeArea()
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .frame(width: 48, height: 48)
                        .background(.black.gradient)
                        .clipShape(Circle())

                    }
                }
        } else {
            Button("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
        .sheet(item: $viewModel.selectedLocation) { place in
            EditView(location: place) {
                viewModel.update(location: $0)
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    ContentView()
}
