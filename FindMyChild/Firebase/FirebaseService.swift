//
//  FirebaseService.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation
import FirebaseFirestore

class FirebaseService {
    static let usersCollectionPath = "users"
    static func createUser(user: User) {
        Firestore.firestore().collection(usersCollectionPath).document(user.id).setData(user.toFirebase())
    }
    
    static func getUser(userId: String, completion: @escaping (User?) -> Void) {
        Firestore.firestore().collection(usersCollectionPath).document(userId).getDocument { snapshot, error in
            if let error = error {
                completion(nil)
            }
            let user = try? snapshot?.data(as: User.self)
            completion(user)
        }
    }
}
