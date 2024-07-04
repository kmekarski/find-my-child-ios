//
//  AuthManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation

protocol AuthManagerProtocol {
    var delegate: AuthDelegateProtocol? { get set }
    var isSignedIn: Bool { get set }
    func signIn()
    func signOut()
}

protocol AuthDelegateProtocol {
    func didStartAuthenticating()
    func didSignIn()
    func didSignOut()
}

class AuthManager: AuthManagerProtocol {
    var delegate: AuthDelegateProtocol?
    
    @Published var isSignedIn: Bool = false
    
    func signIn() {
        isSignedIn = true
        delegate?.didSignIn()
    }
    
    func signOut() {
        isSignedIn = false
        delegate?.didSignOut()
    }
}
