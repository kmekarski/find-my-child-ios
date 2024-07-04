//
//  SignInTextParams.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 17/06/2024.
//

import Foundation

struct SignInTextParams {
    var email: String = ""
    var password: String = ""
    
    static let emailHint = String(localized: "email_string")
    static let passwordHint = String(localized: "password_string")
}
