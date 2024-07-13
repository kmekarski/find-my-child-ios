//
//  ValidationManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/07/2024.
//

import Foundation

class ValidationManager {
    static func validateNonEmptyField(_ field: String) -> Result<Bool, SignUpError> {
        return field.isEmpty ? .failure(.emptyField) : .success(true)
    }
    
    static func validateEmail(_ email: String) -> SignUpValidationResult {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) ? .success(true) : .failure(.emailInvalid)
    }
    
    static func validatePassword(_ password: String) -> SignUpValidationResult {
        return password.count >= 8 ? .success(true) : .failure(.weakPassword)
    }
    
    static func validatePhoneNumber(_ phoneNumber: String) -> Result<Bool, SignUpError> {
        let phoneNumberRegex = "^[0-9]{9,15}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phonePredicate.evaluate(with: phoneNumber) ? .success(true) : .failure(.phoneNumberInvalid)
    }
    
    static func validateUsername(_ username: String) -> Result<Bool, SignUpError> {
        guard username.count >= 3 && username.count <= 15 else { return .failure(.usernameWrongLength) }
        let usernameRegex = "^[A-Za-z0-9_]{3,15}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username) ? .success(true) : .failure(.usernameInvalid)
    }
    
    static func validatePasswordsMatch(_ password: String, _ confirmPassword: String) -> SignUpValidationResult {
        return password == confirmPassword ? .success(true) : .failure(.passwordsDoNotMatch)
    }
}
