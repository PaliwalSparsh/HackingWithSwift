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
    @State var locations: [Location] = []
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 50), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @State var selectedLocation: Location? = nil
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) {
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
                        selectedLocation = location
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
                        locations.append(Location(id: UUID(), name: "New location", description: "", longitude: mapRegion.center.longitude, latitude: mapRegion.center.latitude))
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .frame(width: 48, height: 48)
                            .background(.black.gradient)
                            .clipShape(Circle())
                    }.padding()
                }
            }
        }
        .sheet(item: $selectedLocation) { place in
            EditView(location: place, onSave: { newLocation in
                if let index = locations.firstIndex(of: place) {
                    locations[index] = newLocation
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
