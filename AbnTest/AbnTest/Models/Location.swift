//
//  Location.swift
//  AbnTest
//
//  Created by Tim van der Vooren on 13/06/2023.
//

import Foundation

struct Location: Identifiable {
    let id: UUID
    let name: String?
    let lat: Double
    let long: Double
    
    init(id: UUID = UUID(), name: String? = nil, lat: Double, long: Double) {
        self.id = id
        self.name = name
        self.lat = lat
        self.long = long
    }
}

extension Location {
    static let sampleData: [Location] =
    [
        Location(name: "Amsterdam", lat: 52.3547498, long: 4.8339215),
        Location(name: "Mumbai", lat: 19.0823998, long: 72.8111468),
        Location(name: "Copenhagen", lat: 55.6713442, long: 12.523785),
        Location(lat: 40.4380638, long: -3.7495758)
    ]
}
