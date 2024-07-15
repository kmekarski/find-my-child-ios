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
        if let authUser = Auth.auth().currentUser {
            handleSignInSuccess(userId: authUser.uid)
        }
    }
    
    func signIn(email: String, password: String) {
        delegate?.didStartAuthenticating()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            guard let userId = result?.user.uid, error == nil else {
                handleError(error: error!)
                return
            }
            handleSignInSuccess(userId: userId)
        }
    }
    
    func signUp(username: String, email: String, password: String, phoneNumber: String, type: UserType) {
        delegate?.didStartAuthenticating()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            guard let userId = result?.user.uid, error == nil else {
                handleError(error: error!)
                return
            }
            let newUser = User(id: userId,username: username, email: email, phoneNumber: phoneNumber, type: type)
            do {
                try FirebaseService.createUser(user: newUser)
                switch type {
                case .parent:
                    let parentUser = ParentUser(user: newUser)
                    try FirebaseService.createParentUser(user: parentUser)
                case .child:
                    let childUser = ChildUser(user: newUser)
                    try FirebaseService.createChildUser(user: childUser)
                }
                isSignedIn = true
                delegate?.didSignUp(result: .success(newUser))
            } catch {
                delegate?.didSignUp(result: .failure(.somethingWentWrong))
            }
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
    
    private func handleSignInSuccess(userId: String) {
        FirebaseService.getUser(userId: userId) { [weak self] user in
            guard let user = user else {
                self?.delegate?.didSignIn(result: .failure(.somethingWentWrong))
                return
            }
            self?.isSignedIn = true
            self?.delegate?.didSignIn(result: .success(user))
        }
    }
    
    private func handleError(error: any Error) {
        self.isSignedIn = false
        let authError = getAuthError(error)
        delegate?.didSignUp(result: .failure(authError))
    }
}
