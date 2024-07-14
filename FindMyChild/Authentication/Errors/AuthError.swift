//
//  AuthError.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation


enum AuthError: AuthErrorProtocol {
    case signIn(SignInError)
    case signUp(SignUpError)
    case somethingWentWrong
    
    var message: String {
        return switch self {
        case .signIn(let error): error.message
        case .signUp(let error): error.message
        case .somethingWentWrong: String(localized: "something_went_wrong_message_string")
        }
    }
}
