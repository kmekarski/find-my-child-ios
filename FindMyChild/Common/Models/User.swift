//
//  User.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

struct User: Codable {
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
    
    func toFirebase() -> [String: Any] {
        return [
            "id": id,
            "username": username,
            "email": email,
            "phoneNumber": phoneNumber,
            "type": type.rawValue
        ]
    }
    
    static func fromFirebase(_ json: [String: Any]) -> User? {
        guard
            let id = json["id"] as? String,
            let username = json["username"] as? String,
            let email = json["email"] as? String,
            let phoneNumber = json["phoneNumber"] as? String,
            let typeRawValue = json["type"] as? String,
            let type = UserType(rawValue: typeRawValue)
        else {
            return nil
        }
        
        return User(id: id, username: username, email: email, phoneNumber: phoneNumber, type: type)
    }
}
