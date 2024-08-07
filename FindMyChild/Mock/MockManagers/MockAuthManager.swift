//
//  MockAuthManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 25/06/2024.
//

import Foundation

class MockAuthManager: AuthManagerProtocol {
    @Published var state: AuthState = .idle
    var statePublisher: Published<AuthState>.Publisher { $state }
    
    var currentUser: User?
    
    func validateSignUp(username: String, email: String, password: String, repeatPassword: String, phoneNumber: String) -> AuthValidationResult {
        let validations =  [ValidationManager.validateNonEmptyField(username),
            ValidationManager.validateUsername(username),
            ValidationManager.validateNonEmptyField(email),
            ValidationManager.validateEmail(email),
            ValidationManager.validateNonEmptyField(password),
            ValidationManager.validatePassword(password),
            ValidationManager.validatePasswordsMatch(password, repeatPassword),
            ValidationManager.validateNonEmptyField(phoneNumber),
            ValidationManager.validatePhoneNumber(phoneNumber)
        ]
        for result in validations {
            switch result {
            case .success(_):
                continue
            case .failure(let error):
                return .failure(error)
            }
        }
        return .success(true)
    }
    
    func validateSignIn(email: String, password: String) -> AuthValidationResult {
        let validations =  [ValidationManager.validateNonEmptyField(email), ValidationManager.validateNonEmptyField(password)]
        for result in validations {
            switch result {
            case .success(_):
                continue
            case .failure(let error):
                return .failure(error)
            }
        }
        return .success(true)
    }
    
    func checkAuthentication() {
        state = .authenticating
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSignedIn = true
            self.currentUser = MockData.parentUser
            self.state = .signedIn(MockData.parentUser)
        }
    }
    
    func signIn(email: String, password: String) {
        state = .authenticating
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSignedIn = true
            self.currentUser = MockData.parentUser
            self.state = .signedIn(MockData.parentUser)
        }
    }
    
    func signUp(username: String, email: String, password: String, phoneNumber: String, type: UserType) {
        state = .authenticating
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSignedIn = true
            self.currentUser = MockData.parentUser
            self.state = .signedUp(MockData.parentUser)
        }
    }
    
    var isSignedIn: Bool = false
    
    func signOut() {
        state = .authenticating
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSignedIn = true
            self.state = .signedOut
        }
    }
}
