//
//  User.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

class User: Codable {
    let id: String
    let username: String
    let email: String
    let phoneNumber: String
    let type: UserType
    
    init(id: String, username: String, email: String, phoneNumber: String, type: UserType) {
        self.id = id
        self.username = username
        self.email = email
        self.phoneNumber = phoneNumber
        self.type = type
    }
}
