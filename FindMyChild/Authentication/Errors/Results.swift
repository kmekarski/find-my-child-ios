//
//  Results.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

typealias AuthResult = Result<User, AuthError>

typealias SignOutResult = Result<Bool, AuthError>

typealias AuthValidationResult = Result<Bool, AuthValidationError>
