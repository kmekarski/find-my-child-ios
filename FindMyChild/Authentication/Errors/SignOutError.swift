//
//  SignOutError.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

enum SignOutError: AuthError {
    case somethingWentWrong
    var message: String {
        return String(localized: "something_went_wrong_message_string")
    }
}
