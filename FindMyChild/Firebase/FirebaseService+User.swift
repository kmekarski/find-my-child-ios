//
//  FirebaseService+User.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/07/2024.
//

import Foundation
import FirebaseFirestore

extension FirebaseService {
    static let usersCollectionPath = "users"
    static func createUser(user: User) throws {
        try createDocument(document: user, documentId: user.id, collectionPath: usersCollectionPath)
    }
    
    static func getUser(userId: String, completion: @escaping (User?) -> Void) {
        getDocument(documentId: userId, collectionPath: usersCollectionPath, completion: completion)
    }
}
