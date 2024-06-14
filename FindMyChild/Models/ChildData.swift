//
//  ChildData.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation
import MapKit

struct ChildData {
    var childId: String?
    var coordinate: CLLocationCoordinate2D?
    var locationDescription: String?
    var distance: Int?
    var updatedDate: Date?
    var batteryLevel: Int?
}
