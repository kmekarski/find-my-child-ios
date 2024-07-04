//
//  MockAuthManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 25/06/2024.
//

import Foundation

class MockAuthManager: AuthManagerProtocol {
    var delegate: AuthDelegateProtocol?
    
    var isSignedIn: Bool = false
    
    func signIn() {
        self.delegate?.didStartAuthenticating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSignedIn = true
            self.delegate?.didSignIn()
        }
    }
    
    func signOut() {
        self.delegate?.didStartAuthenticating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSignedIn = true
            self.delegate?.didSignOut()
        }
    }
}
