//
//  AuthManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation
import FirebaseAuth

protocol AuthManagerProtocol {
    var delegate: AuthDelegateProtocol? { get set }
    var isSignedIn: Bool { get set }
    func checkAuthentication()
    func signIn(email: String, password: String)
    func signUp(username: String, email: String, password: String, phoneNumber: String, type: UserType)
    func signOut()
    func validateSignIn(email: String, password: String) -> AuthValidationResult
    func validateSignUp(username: String, email: String, password: String, repeatPassword: String, phoneNumber: String) -> AuthValidationResult
}

protocol AuthDelegateProtocol {
    func didStartAuthenticating()
    func didSignIn(result: AuthResult)
    func didSignUp(result: AuthResult)
    func didSignOut(result: SignOutResult)
}

class AuthManager: AuthManagerProtocol {
    var delegate: AuthDelegateProtocol?
    @Published var isSignedIn: Bool = false
    
    func checkAuthentication() {
        if let user = Auth.auth().currentUser {
            let authUser = MockData.parentAuthUser
            self.isSignedIn = true
            delegate?.didSignIn(result: .success(authUser))
        }
    }
    
    func signIn(email: String, password: String) {
        delegate?.didStartAuthenticating()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            guard let user = result?.user,
                  error == nil else {
                self.isSignedIn = false
                let authError = getAuthError(error)
                delegate?.didSignIn(result: .failure(authError))
                return
            }
            let authUser = AuthUser(id: user.uid, username: "someUser", email: user.email ?? "someEmail", phoneNumber: "123456789", type: .parent)
            self.isSignedIn = true
            delegate?.didSignIn(result: .success(authUser))
        }
    }
    
    func signUp(username: String, email: String, password: String, phoneNumber: String, type: UserType) {
        delegate?.didStartAuthenticating()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            guard let user = result?.user, error == nil else {
                self.isSignedIn = false
                let authError = getAuthError(error)
                delegate?.didSignUp(result: .failure(authError))
                return
            }
            let authUser = AuthUser(id: user.uid, username: username, email: email, phoneNumber: phoneNumber, type: type)
            self.isSignedIn = true
            delegate?.didSignUp(result: .success(authUser))
        }
    }
    
    func signOut() {
        delegate?.didStartAuthenticating()
        do {
            try Auth.auth().signOut()
        } catch(let error) {
            delegate?.didSignOut(result: .failure(getAuthError(error)))
        }
        isSignedIn = false
        delegate?.didSignOut(result: .success(true))

    }
}
