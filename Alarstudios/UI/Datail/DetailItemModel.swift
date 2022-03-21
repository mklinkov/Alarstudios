//
//  DitailItemModel.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 21.03.2022.
//

import Foundation
import MapKit

struct DetailItemModel {
    let name: String
    let country: String
    let locationString: String
    let pointLocation: CLLocationCoordinate2D
    
    init(_ item: PageModel.Item) {
        self.name = item.name
        self.country = item.country
        self.locationString =  "Широта: \(item.lat)\nДолгота: \(item.lon)"
        let lat = CLLocationDegrees(item.lat)
        let lon = CLLocationDegrees(item.lon)
        pointLocation = .init(latitude: lat, longitude: lon)
    }
}
