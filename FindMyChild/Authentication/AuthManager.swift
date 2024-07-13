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
    func signIn(email: String, password: String)
    func signOut()
    func validateSignIn(email: String, password: String) -> AuthValidationResult
    func validateSignUp(username: String, email: String, password: String, repeatPassword: String, phoneNumber: String) -> AuthValidationResult
}

protocol AuthDelegateProtocol {
    func didStartAuthenticating()
    func didSignIn()
    func didSignOut()
}

class AuthManager: AuthManagerProtocol {
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
            case .success(let success):
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
            case .success(let success):
                continue
            case .failure(let error):
                return .failure(error)
            }
        }
        return .success(true)
    }
    
    var delegate: AuthDelegateProtocol?
    
    @Published var isSignedIn: Bool = false
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
        }
        isSignedIn = true
        delegate?.didSignIn()
    }
    
    func signOut() {
        isSignedIn = false
        delegate?.didSignOut()
    }
}
