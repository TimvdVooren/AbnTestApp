//
//  ContentView.swift
//  AbnTest
//
//  Created by Tim van der Vooren on 13/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var locations: [Location] = []
    @State private var newLocationName = ""
    
    var body: some View {
        
        Form {
            Section(header: Text("Saved locations")) {
                List(locations) { location in
                    HStack {
                        Text(location.name ?? "Unnamed location")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .onTapGesture {
                        UIApplication
                            .shared
                            .open(URL(string: "wikipedia://places?lat=\(location.lat)&long=\(location.long)")!)
                    }
                }
            }
            .onAppear {
                Location.fetchFromApi { result in
                    locations = result
                }
            }
            
            Section(header: Text("Add a location")) {
                HStack {
                    TextField("New location", text: $newLocationName)
                    
                    Button(action: {
                        withAnimation {
                            var lat = 0.0
                            var long = 0.0
                            
                            Location.getCoordinatesByCityName(cityName: newLocationName) { coordinates in
                                if let coordinates = coordinates {
                                    print("Latitude: \(coordinates.latitude), Longitude: \(coordinates.longitude)")
                                    
                                    lat = coordinates.latitude
                                    long = coordinates.longitude
                                    
                                    let location = Location(name: newLocationName, lat: lat, long: long)
                                    locations.append(location)
                                } else {
                                    print("Unable to retrieve coordinates")
                                }
                                
                                newLocationName = ""
                            }
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newLocationName.isEmpty)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
