//
//  AuthViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 25/06/2024.
//

import Foundation
import SwiftUI

protocol AuthViewModelDelegate {
    func showAuthErrorMessage(_ error: AuthErrorProtocol)
}

class AuthViewModel: ObservableObject {
    var authManager: AuthManagerProtocol
    var delegate: AuthViewModelDelegate?
    
    @Published var currentUser: AuthUser?
    @Published var isSignedIn: Bool = false
    @Published var isAuthenticating: Bool = false
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
        self.authManager.delegate = self
        self.authManager.checkAuthentication()
    }
    
    func didAuthenticate(result: AuthResult) {
        isAuthenticating = false
        switch result {
        case .success(let authUser):
            withAnimation() {
                isSignedIn = true
                currentUser = authUser
            }
        case .failure(let error):
            delegate?.showAuthErrorMessage(error)
        }
    }
    
    func signOut() {
        authManager.signOut()
    }
}

extension AuthViewModel: AuthDelegateProtocol {
    func didStartAuthenticating() {
        isAuthenticating = true
    }
    
    func didSignIn(result: AuthResult) {
        didAuthenticate(result: result)
    }
    
    func didSignUp(result: AuthResult) {
        didAuthenticate(result: result)
    }
    
    func didSignOut(result: SignOutResult) {
        isAuthenticating = false
        switch result {
        case .success(_):
            withAnimation() {
                isSignedIn = false
            }
        case .failure(let error):
            delegate?.showAuthErrorMessage(error)
        }
    }
}
