//
//  AuthManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation

class AuthManager: ObservableObject {
    @Published var isSignedIn: Bool = false
    
    func signIn() {
        isSignedIn = true
    }
    
    func signOut() {
        isSignedIn = false
    }
}

protocol AuthManagerProtocol {
    var isSignedIn: Bool { get set }
    func signIn()
    func signOut()
}
