//
//  MockData+Auth.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

extension MockData {
    static let parentAuthUser = AuthUser(id: "1", username: "mockParent", email: "mockParent@gmail.com", phoneNumber: "123456789", type: .parent)
    static let childAuthUser = AuthUser(id: "2", username: "mockChild", email: "mockChild@gmail.com", phoneNumber: "987654321", type: .child)
}
