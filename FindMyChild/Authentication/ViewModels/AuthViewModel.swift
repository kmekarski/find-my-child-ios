//
//  AuthViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 25/06/2024.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject, AuthDelegateProtocol {
    var authManager: AuthManagerProtocol
    
    @Published var isSignedIn: Bool = false
    @Published var isAuthenticating: Bool = false
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
        self.authManager.delegate = self
    }
    
    func didStartAuthenticating() {
        isAuthenticating = true
    }
    
    func didSignIn() {
        isAuthenticating = false
        withAnimation() {
            isSignedIn = true
        }
    }
    
    func didSignOut() {
        isAuthenticating = false
        withAnimation() {
            isSignedIn = false
        }
    }
}
