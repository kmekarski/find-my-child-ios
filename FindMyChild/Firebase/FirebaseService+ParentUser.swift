//
//  Firebase+ParentUser.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/07/2024.
//

import Foundation
import FirebaseFirestore

extension FirebaseService {
    static let parentUsersCollectionPath = "parentUsers"
    static func createParentUser(user: ParentUser) throws {
        try createDocument(document: user, documentId: user.id, collectionPath: parentUsersCollectionPath)
    }
    
    static func getParentUser(userId: String, completion: @escaping (ParentUser?) -> Void) {
        getDocument(documentId: userId, collectionPath: parentUsersCollectionPath, completion: completion)
    }
}
