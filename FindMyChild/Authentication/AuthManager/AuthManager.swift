//
//  AuthManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation
import FirebaseAuth
import Combine

enum AuthState {
    case idle
    case authenticating
    case signedUp(User)
    case signedIn(User)
    case signedOut
    case error(AuthError)
}

protocol AuthManagerProtocol {
    var state: AuthState { get set }
    var statePublisher: Published<AuthState>.Publisher { get }
    var currentUser: User? { get set }
    var isSignedIn: Bool { get set }
    func checkAuthentication() async
    func signIn(email: String, password: String) async
    func signUp(username: String, email: String, password: String, phoneNumber: String, type: UserType) async
    func signOut()
    func validateSignIn(email: String, password: String) -> AuthValidationResult
    func validateSignUp(username: String, email: String, password: String, repeatPassword: String, phoneNumber: String) -> AuthValidationResult
}

class AuthManager: AuthManagerProtocol, ObservableObject {
    @Published var state: AuthState = .idle
    var statePublisher: Published<AuthState>.Publisher { $state }
    
    var isSignedIn: Bool = false
    var currentUser: User?
    
    func checkAuthentication() async {
        if let authUser = Auth.auth().currentUser {
            await handleSignInSuccess(userId: authUser.uid)
        }
    }
    
    func signIn(email: String, password: String) async {
        state = .authenticating
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let userId = result.user.uid
            await handleSignInSuccess(userId: userId)
        } catch {
            handleError(error: error)
        }
    }
    
    func signUp(username: String, email: String, password: String, phoneNumber: String, type: UserType) async {
        state = .authenticating
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let userId = result.user.uid
            let newUser = User(id: userId, username: username, email: email, phoneNumber: phoneNumber, type: type, imageUrl: nil, isFirstLogin: true, children: [])
            try FirebaseService.createUser(user: newUser)
            isSignedIn = true
            self.currentUser = newUser
            state = .signedUp(newUser)
        } catch {
            handleError(error: error)
        }
    }
    
    func signOut() {
        state = .authenticating
        do {
            try Auth.auth().signOut()
        } catch(let error) {
            state = .error(getAuthError(error))
        }
        isSignedIn = false
        state = .signedOut
        
    }
    
    private func handleSignInSuccess(userId: String) async {
        do {
            guard let user = try await FirebaseService.getUser(userId: userId) else {
                state = .error(.somethingWentWrong)
                return
            }
            self.isSignedIn = true
            self.currentUser = user
            state = .signedIn(user)
        } catch {
            state = .error(.somethingWentWrong)
        }
    }
    
    private func handleError(error: any Error) {
        print(error.localizedDescription)
        self.isSignedIn = false
        let authError = getAuthError(error)
        state = .error(authError)
    }
}
