//
//  SignUpError.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

enum SignUpError: AuthError {
    case emailAlreadyTaken
    var message: String {
        return String(localized: "email_already_taken_message_string")
    }
}
