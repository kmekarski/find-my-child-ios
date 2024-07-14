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

class AuthViewModel: ObservableObject, AuthDelegateProtocol {
    var authManager: AuthManagerProtocol
    var delegate: AuthViewModelDelegate?
    
    @Published var currentUser: AuthUser?
    @Published var isSignedIn: Bool = false
    @Published var isAuthenticating: Bool = false
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
        self.authManager.delegate = self
    }
    
    func didStartAuthenticating() {
        isAuthenticating = true
    }
    
    func didAuthenticate(result: AuthResult) {
        
    }
    
    func didSignIn(result: AuthResult) {
        isAuthenticating = false
        switch result {
        case .success(let authUser):
            withAnimation() {
                isSignedIn = true
                currentUser = authUser
                print("username: " + authUser.username)
            }
        case .failure(let error):
            delegate?.showAuthErrorMessage(error)
        }
    }
    
    func didSignUp(result: AuthResult) {
        isAuthenticating = false
        switch result {
        case .success(let authUser):
            withAnimation() {
                isSignedIn = true
                currentUser = authUser
                print("username: " + authUser.username)
            }
        case .failure(let error):
            delegate?.showAuthErrorMessage(error)
        }
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
