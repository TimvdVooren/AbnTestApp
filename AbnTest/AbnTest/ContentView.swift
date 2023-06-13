//
//  ContentView.swift
//  AbnTest
//
//  Created by Tim van der Vooren on 13/06/2023.
//

import SwiftUI

struct ContentView: View {
    let locations: [Location]
    
    var body: some View {
        List(locations) { location in
            HStack {
                Text(location.name)
            }
            .onTapGesture {
                UIApplication
                    .shared
                    .open(URL(string: "wikipedia://places?lat=\(location.lat)?long=\(location.long)")!)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(locations: Location.sampleData)
    }
}
