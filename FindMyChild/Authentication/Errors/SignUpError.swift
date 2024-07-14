//
//  SignUpError.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

enum SignUpError: AuthErrorProtocol {
    case emailAlreadyTaken
    var message: String {
        return String(localized: "email_already_taken_message_string")
    }
}
