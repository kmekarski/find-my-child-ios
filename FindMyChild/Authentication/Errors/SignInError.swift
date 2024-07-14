//
//  SignInError.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

enum SignInError: AuthError {
    case wrongCredentials
    var message: String {
        return String(localized: "wrong_credentials_message_string")
    }
}
