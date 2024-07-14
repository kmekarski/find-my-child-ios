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
    func didSignIn(result: SignInResult)
    func didSignOut(result: SignOutResult)
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
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            guard let user = result?.user, 
                    let username = user.displayName,
                  let email = user.email,
                    error == nil else {
                self.isSignedIn = false
                delegate?.didSignIn(result: .failure(.wrongCredentials))
                return
            }
            let authUser = AuthUser(id: user.uid, username: username, email: email, phoneNumber: "123456789", type: .parent)
            self.isSignedIn = true
            delegate?.didSignIn(result: .success(authUser))
        }
    }
    
    func signOut() {
        isSignedIn = false
        delegate?.didSignOut(result: .success(true))
    }
}
