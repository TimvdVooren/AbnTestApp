//
//  ContentView.swift
//  AbnTest
//
//  Created by Tim van der Vooren on 13/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var locations: [Location] = []
    
    var body: some View {
        List(locations) { location in
            HStack {
                if (location.name != nil) {
                    Text(location.name!)
                } else {
                    Text("Unnamed location")
                }
            }
            .onTapGesture {
                UIApplication
                    .shared
                    .open(URL(string: "wikipedia://places?lat=\(location.lat)?long=\(location.long)")!)
            }
        }
        .onAppear {
            Location.fetchFromApi { result in
                locations = result
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
