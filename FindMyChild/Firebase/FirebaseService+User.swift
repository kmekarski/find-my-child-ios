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
    
    static func createParentOrChildUser(user: User, type: UserType) throws {
        switch type {
        case .parent:
            try createParentUser(user: user as! ParentUser)
        case .child:
            try createChildUser(user: user as! ChildUser)
        }
    }
    
    static func getUser(userId: String, completion: @escaping (User?) -> Void) {
        getDocument(documentId: userId, collectionPath: usersCollectionPath, completion: completion)
    }
    
    static func getParentOrChildUser(userId: String, type: UserType, completion: @escaping (User?) -> Void) {
        switch type {
        case .parent:
            getParentUser(userId: userId, completion: completion)
        case .child:
            getChildUser(userId: userId, completion: completion)
        }
    }
    
    static func getUser(userId: String) async throws -> User? {
        return try await Firestore.firestore().collection(usersCollectionPath).document(userId).getDocument(as: User.self)
    }
}
