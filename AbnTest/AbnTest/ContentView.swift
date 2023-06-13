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
            if location.name != nil {
                Text(location.name!)
            } else {
                Text("Unnamed location")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(locations: Location.sampleData)
    }
}
