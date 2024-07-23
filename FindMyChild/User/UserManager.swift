//
//  UserManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 23/07/2024.
//

import Foundation

protocol UserManagerProtocol {
    func finishParentOnboarding(userId: String) async throws
}

class MockUserManager: UserManagerProtocol {
    func finishParentOnboarding(userId: String) async throws {
        
    }
}

class UserManager: UserManagerProtocol {
    func finishParentOnboarding(userId: String) async throws {
        let userUpdateData = ["isFirstLogin": false]
        try await FirebaseService.modifyUser(userId: userId, newData: userUpdateData)
    }
}
