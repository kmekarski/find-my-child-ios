//
//  AuthValidationError.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/07/2024.
//

import Foundation

enum AuthValidationError: AuthErrorProtocol {
    case signIn(SignInValidationError)
    case signUp(SignUpValidationError)
    case emptyField
    
    var message: String {
        return switch self {
        case .signIn(let error): error.message
        case .signUp(let error): error.message
        case .emptyField: String(localized: "empty_field_message_string")
        }
    }
}
