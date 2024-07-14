//
//  UserType.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 25/06/2024.
//

import Foundation

enum UserType: String, Codable {
    case parent
    case child
    
    var text: String {
        switch self {
        case .parent:
            return String(localized: "parent_string")
        case .child:
            return String(localized: "child_string")
        }
    }
    
    var icon: String {
        switch self {
        case .parent:
            return "figure.and.child.holdinghands"
        case .child:
            return "figure.child"
        }
    }
}
