//
//  SignUpError.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/07/2024.
//

import Foundation

enum SignUpValidationError: AuthError {
    case emptyField
    case usernameInvalid
    case usernameWrongLength
    case emailInvalid
    case phoneNumberInvalid
    case weakPassword
    case passwordsDoNotMatch
    
    var message: String {
        return switch self {
        case .emptyField: String(localized: "empty_field_message_string")
        case .emailInvalid: String(localized: "email_invalid_message_string")
        case .weakPassword: String(localized: "weak_password_message_string")
        case .usernameInvalid: String(localized: "username_invalid_message_string")
        case .usernameWrongLength: String(localized: "username_wrong_length_message_string")
        case .phoneNumberInvalid: String(localized: "phone_number_invalid_message_string")
        case .passwordsDoNotMatch: String(localized: "passwords_do_not_match_message_string")
        }
    }
}
