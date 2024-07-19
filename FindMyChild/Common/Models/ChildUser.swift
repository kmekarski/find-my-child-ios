//
//  Child.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/07/2024.
//

import Foundation

class ChildUser: User {
    var childProperty: String = "blablabla"
    
    init(user: User, childProperty: String = "lalala") {
        self.childProperty = childProperty
        super.init(
            id: user.id,
            username: user.username,
            email: user.email,
            phoneNumber: user.phoneNumber,
            type: .child,
            imageUrl: user.imageUrl
        )
    }
    
    init(id: String, username: String, email: String, phoneNumber: String, imageUrl: String?, childProperty: String = "lalala") {
        self.childProperty = childProperty
        super.init(id: id, username: username, email: email, phoneNumber: phoneNumber, type: .parent, imageUrl: imageUrl)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.childProperty = try container.decode(String.self, forKey: .childProperty)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(childProperty, forKey: .childProperty)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case childProperty
    }
}
