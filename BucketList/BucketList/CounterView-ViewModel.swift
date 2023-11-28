//
//  CounterView-ViewModel.swift
//  BucketList
//
//  Created by Sparsh Paliwal on 11/28/23.
//

import Foundation
import MapKit

extension ContentView {
    /// Using @MainActor we are insuring this class runs on main actor, obviously we need to do this, because we want UI update logic works on main thread
    @MainActor class ViewModel: ObservableObject {
        @Published var locations: [Location] = []
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 50), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published var selectedLocation: Location? = nil
        /// We get document directory and append the name of the new file we want to created
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

        init() {
            do {
                /// Data contents is super easy way to read data from a path on disk.
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                /// Using this approach we can write any amount of data in any number of files – it’s much more flexible than UserDefaults, and also allows us to load and save data as needed rather than immediately when the app launches as with UserDefaults.

                let data = try JSONEncoder().encode(locations)
                /// completeFileProtection allows encryption and atomic specifies the unique way in which data is written to disk.
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
    
        func addLocation() {
            locations.append(Location(id: UUID(), name: "New location", description: "", longitude: mapRegion.center.longitude, latitude: mapRegion.center.latitude))
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedLocation else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            save()
        }
    }
}
