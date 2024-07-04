//
//  SignUpField.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/06/2024.
//

import Foundation

struct SignUpTextParams {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var repeatPassword: String = ""
    var phoneNumber: String = ""
    
    static let nameHint = String(localized: "name_string")
    static let emailHint = String(localized: "email_string")
    static let passwordHint = String(localized: "password_string")
    static let repeatPasswordHint = String(localized: "repeat_password_string")
    static let phoneNumberHint = String(localized: "phone_number_string")
}
