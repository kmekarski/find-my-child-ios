//
//  Child.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation

struct Child: Identifiable, Codable {
    var id: String
    var name: String
    var phoneNumber: String?
}
