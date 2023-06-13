//
//  AbnTestApp.swift
//  AbnTest
//
//  Created by Tim van der Vooren on 13/06/2023.
//

import SwiftUI

@main
struct AbnTestApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: fetch JSON from https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json
            ContentView(locations: Location.sampleData)
        }
    }
}
