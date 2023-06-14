//
//  Location.swift
//  AbnTest
//
//  Created by Tim van der Vooren on 13/06/2023.
//

import Foundation
import CoreLocation

struct Location: Codable, Identifiable {
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
    
    init(from decoder: Decoder) throws {
        self.id = UUID()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.long = try container.decode(Double.self, forKey: .long)
    }
}

struct LocationData: Codable {
    let locations: [Location]
}

extension Location {
    static let sampleData: [Location] =
    [
        Location(name: "Amsterdam", lat: 52.3547498, long: 4.8339215),
        Location(name: "Mumbai", lat: 19.0823998, long: 72.8111468),
        Location(name: "Copenhagen", lat: 55.6713442, long: 12.523785),
        Location(lat: 40.4380638, long: -3.7495758)
    ]
    
    static func fetchFromApi(completion: @escaping ([Location]) -> ()) {
        guard let url = URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json") else {
            fatalError("Invalid URL.")
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let jsonData = data else {
                print("No data received.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let locationData = try decoder.decode(LocationData.self, from: jsonData)
                
                DispatchQueue.main.async {
                    completion(locationData.locations)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        .resume()
    }
    
    static func getCoordinatesByCityName(cityName: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first,
                  let location = placemark.location else {
                completion(nil)
                return
            }
            
            let coordinates = location.coordinate
            completion(coordinates)
        }
    }
}
