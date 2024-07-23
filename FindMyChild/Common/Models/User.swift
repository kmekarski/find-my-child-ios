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
    let imageUrl: String?
    let isFirstLogin: Bool
    let children: [Child]
    
    init(id: String, username: String, email: String, phoneNumber: String, type: UserType, imageUrl: String?, isFirstLogin: Bool, children: [Child]) {
        self.id = id
        self.username = username
        self.email = email
        self.phoneNumber = phoneNumber
        self.type = type
        self.imageUrl = imageUrl
        self.isFirstLogin = isFirstLogin
        self.children = children
    }
}
