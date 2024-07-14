//
//  AuthManager+Errors.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation
import FirebaseAuth

extension AuthManager {
    func getAuthError(_ error: Error?) -> AuthError {
        guard let error = error as NSError?,
            let errorCode = AuthErrorCode.Code(rawValue: error.code) else {
            return .somethingWentWrong
        }
        return switch errorCode {
        case .emailAlreadyInUse: .signUp(.emailAlreadyTaken)
        case .wrongPassword: .signIn(.wrongCredentials)
        default: .somethingWentWrong
        }
    }
}
