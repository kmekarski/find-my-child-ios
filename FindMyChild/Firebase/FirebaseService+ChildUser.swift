//
//  FirebaseService+ChildUser.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/07/2024.
//

import Foundation
import FirebaseFirestore

extension FirebaseService {
    static let childUsersCollectionPath = "childUsers"
    static func createChildUser(user: ChildUser) throws {
        try createDocument(document: user, documentId: user.id, collectionPath: childUsersCollectionPath)
    }
    
    static func getChildUser(userId: String, completion: @escaping (ChildUser?) -> Void) {
        getDocument(documentId: userId, collectionPath: childUsersCollectionPath, completion: completion)
    }
}
