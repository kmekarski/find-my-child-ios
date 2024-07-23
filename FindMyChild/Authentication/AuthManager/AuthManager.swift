//
//  AuthManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation
import FirebaseAuth

protocol AuthManagerProtocol {
    var currentUser: User? { get set }
    var delegate: AuthDelegateProtocol? { get set }
    var isSignedIn: Bool { get set }
    func checkAuthentication() async
    func signIn(email: String, password: String) async
    func signUp(username: String, email: String, password: String, phoneNumber: String, type: UserType) async
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
    var isSignedIn: Bool = false
    var currentUser: User?
    
    func checkAuthentication() async {
        if let authUser = Auth.auth().currentUser {
            await handleSignInSuccess(userId: authUser.uid)
        }
    }
    
    func signIn(email: String, password: String) async {
        delegate?.didStartAuthenticating()
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let userId = result.user.uid
            await handleSignInSuccess(userId: userId)
        } catch {
            handleError(error: error)
        }
    }
    
    func signUp(username: String, email: String, password: String, phoneNumber: String, type: UserType) async {
        delegate?.didStartAuthenticating()
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let userId = result.user.uid
            let newUser = User(id: userId, username: username, email: email, phoneNumber: phoneNumber, type: type, imageUrl: nil, isFirstLogin: true, children: [])
            try FirebaseService.createUser(user: newUser)
            isSignedIn = true
            self.currentUser = newUser
            delegate?.didSignUp(result: .success(newUser))
        } catch {
            handleError(error: error)
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
    
    private func handleSignInSuccess(userId: String) async {
        do {
            guard let user = try await FirebaseService.getUser(userId: userId) else {
                self.delegate?.didSignIn(result: .failure(.somethingWentWrong))
                return
            }
            self.isSignedIn = true
            self.currentUser = user
            self.delegate?.didSignIn(result: .success(user))
        } catch {
            delegate?.didSignIn(result: .failure(.somethingWentWrong))
        }
    }
    
    private func handleError(error: any Error) {
        print(error.localizedDescription)
        self.isSignedIn = false
        let authError = getAuthError(error)
        delegate?.didSignUp(result: .failure(authError))
    }
}
