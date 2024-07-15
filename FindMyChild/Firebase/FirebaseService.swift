//
//  FirebaseService.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation
import FirebaseFirestore

class FirebaseService {
    internal static func createDocument<T: Encodable>(document: T, documentId: String, collectionPath: String) throws {
        try Firestore.firestore().collection(collectionPath).document(documentId).setData(from: document)
    }
    
    internal static func getDocument<T: Decodable>(documentId: String, collectionPath: String, completion: @escaping (T?) -> Void) {
        Firestore.firestore().collection(collectionPath).document(documentId).getDocument { snapshot, error in
            guard error == nil else {
                completion(nil)
                return
            }
            let document = try? snapshot?.data(as: T.self)
            completion(document)
        }
    }
}
