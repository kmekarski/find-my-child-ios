//
//  AuthManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation

class AuthManager: ObservableObject {
    @Published var signedIn: Bool = false
    
    func signIn() {
        signedIn = true
    }
    
    func signOut() {
        signedIn = false
    }
}
