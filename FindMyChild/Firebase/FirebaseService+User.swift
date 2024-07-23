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
    
    static func getUser(userId: String) async throws -> User? {
        return try await Firestore.firestore().collection(usersCollectionPath).document(userId).getDocument(as: User.self)
    }
    
    static func modifyUser(userId: String, newData: Encodable) async throws {
        return try await modifyDocument(documentId: userId, collectionPath: usersCollectionPath, newData: newData)
    }
}
