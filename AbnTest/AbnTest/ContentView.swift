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
                    
                    var lat = 0.0
                    var long = 0.0
                    
                    Button(action: {
                        withAnimation {
                            let location = Location(name: newLocationName, lat: lat, long: long)
                            locations.append(location)
                            newLocationName = ""
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
