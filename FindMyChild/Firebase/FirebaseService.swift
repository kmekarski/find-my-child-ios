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
    
    internal static func getDocument<T: Decodable>(documentId: String, collectionPath: String) async throws -> T {
        let documentRef = Firestore.firestore().collection(collectionPath).document(documentId)
        
        do {
            let documentSnapshot = try await documentRef.getDocument()
            guard let documentData = documentSnapshot.data() else {
                throw NSError(domain: "FirestoreError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document data is empty"])
            }
            
            let jsonData = try JSONSerialization.data(withJSONObject: documentData, options: [])
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: jsonData)
            return object
        } catch {
            throw error
        }
    }
    
    internal static func modifyDocument<T: Encodable>(documentId: String, collectionPath: String, newData: T) async throws {
        let documentRef = Firestore.firestore().collection(collectionPath).document(documentId)
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(newData)
            guard let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                throw NSError(domain: "FirestoreError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert JSON data to dictionary"])
            }
            
            try await documentRef.setData(jsonObject, merge: true)
        } catch {
            throw error
        }
    }}
