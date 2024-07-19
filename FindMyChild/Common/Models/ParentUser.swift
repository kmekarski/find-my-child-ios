//
//  Parent.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/07/2024.
//

import Foundation

class ParentUser: User {
    var children: [Child]
    
    init(user: User, children: [Child] = []) {
        self.children = children
        super.init(
            id: user.id,
            username: user.username,
            email: user.email,
            phoneNumber: user.phoneNumber,
            type: .parent, imageUrl: user.imageUrl
        )
    }
    
    init(id: String, username: String, email: String, phoneNumber: String, imageUrl: String?, children: [Child] = []) {
        self.children = children
        super.init(id: id, username: username, email: email, phoneNumber: phoneNumber, type: .parent, imageUrl: imageUrl)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.children = try container.decode([Child].self, forKey: .children)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(children, forKey: .children)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case children
    }
}
