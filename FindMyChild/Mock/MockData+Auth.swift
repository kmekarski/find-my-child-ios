//
//  MockData+Auth.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

extension MockData {
    static let parentAuthUser = AuthUser(id: "1", email: "mockParent@gmail.com")
    static let childAuthUser = AuthUser(id: "2", email: "mockChild@gmail.com")
    static let parentUser = User(id: "1", username: "John Parent", email: "mockParent@gmail.com", phoneNumber: "123456789", type: .parent, imageUrl: "https://randomuser.me/api/portraits/thumb/men/18.jpg", isFirstLogin: false, children: children)
    static let childlessParentUser = User(id: "1", username: "John Parent", email: "mockParent@gmail.com", phoneNumber: "123456789", type: .parent, imageUrl: "https://randomuser.me/api/portraits/thumb/men/18.jpg", isFirstLogin: false, children: [])
    static let childUser = User(id: "2", username: "John Child", email: "mockChild@gmail.com", phoneNumber: "987654321", type: .child, imageUrl: "https://randomuser.me/api/portraits/thumb/women/10.jpg", isFirstLogin: false, children: [])

}
