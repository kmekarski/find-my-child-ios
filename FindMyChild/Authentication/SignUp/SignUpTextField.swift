//
//  SignUpField.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/06/2024.
//

import Foundation

enum SignUpTextField: CaseIterable {
    case name
    case email
    case password
    case repeatPassword
    case phoneNumber
    
    var text: String {
        switch self {
        case .name:
            return String(localized: "name_string")
        case .email:
            return String(localized: "email_string")
        case .password:
            return String(localized: "password_string")
        case .repeatPassword:
            return String(localized: "repeat_password_string")
        case .phoneNumber:
            return String(localized: "phone_number_string")
        }
        
    }
}
