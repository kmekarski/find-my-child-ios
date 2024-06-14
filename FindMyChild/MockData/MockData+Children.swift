//
//  MockData+Children.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation
import MapKit

extension MockData {
    
    private static let indices: [Int] = Range(0...2).map { index in
        index
    }
    
    private static let ids: [String] = indices.map { index in
        String(index)
    }
    
    private static let names = [
        "Sophie",
        "Blake",
        "John"
    ]
    
    private static let phoneNumbers = [
        "128120971",
        "333444555",
        nil
    ]
    
    private static let coordinates = [
        CLLocationCoordinate2D(latitude: 52.237, longitude: 21.018),
        nil,
        CLLocationCoordinate2D(latitude: 50.81, longitude: 19.122),
    ]
    
    private static let locationDescriptions = [
        "Radomiak Radom Stadium",
        nil,
        "Jasna Góra Monastery",
    ]
    
    private static let distances = [
        67897,
        2137,
        nil
    ]
    
    private static let updatedDates = [
        Date(timeIntervalSinceNow: -1000),
        nil,
        Date(timeIntervalSinceNow: -10)
    ]
    
    private static let batteryLevels = [
        nil,
        76,
        9
    ]
    
    static let children: [Child] = indices.map { index in
        Child(
            id: ids[index],
            name: names[index],
            phoneNumber: phoneNumbers[index]
        )
    }
    
    
    static let childrenData: [ChildData] = indices.map { index in
        ChildData(
            childId: ids[index],
            coordinate: coordinates[index],
            locationDescription: locationDescriptions[index],
            distance: distances[index],
            updatedDate: updatedDates[index],
            batteryLevel: batteryLevels[index]
        )
    }
}
