//
//  ValidationManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/07/2024.
//

import Foundation

class ValidationManager {
    static func validateNonEmptyField(_ field: String) -> AuthValidationResult {
        return field.isEmpty ? .failure(.emptyField) : .success(true)
    }
    
    static func validateEmail(_ email: String) -> AuthValidationResult {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) ? .success(true) : .failure(.signUp(.emailInvalid))
    }
    
    static func validatePassword(_ password: String) -> AuthValidationResult {
        return password.count >= 8 ? .success(true) : .failure(.signUp(.weakPassword))
    }
    
    static func validatePhoneNumber(_ phoneNumber: String) -> AuthValidationResult {
        let phoneNumberRegex = "^[0-9]{9,15}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phonePredicate.evaluate(with: phoneNumber) ? .success(true) : .failure(.signUp(.phoneNumberInvalid))
    }
    
    static func validateUsername(_ username: String) -> AuthValidationResult {
        guard username.count >= 3 && username.count <= 15 else { return .failure(.signUp(.usernameWrongLength)) }
        let usernameRegex = "^[A-Za-z0-9_]{3,15}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username) ? .success(true) : .failure(.signUp(.usernameInvalid))
    }
    
    static func validatePasswordsMatch(_ password: String, _ confirmPassword: String) -> AuthValidationResult {
        return password == confirmPassword ? .success(true) : .failure(.signUp(.passwordsDoNotMatch))
    }
}
