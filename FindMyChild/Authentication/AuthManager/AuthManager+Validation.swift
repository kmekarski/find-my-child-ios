//
//  AuthManager+Validation.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

extension AuthManager {
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
}
