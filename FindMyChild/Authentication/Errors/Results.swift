//
//  Results.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation

typealias SignInResult = Result<AuthUser, SignInError>

typealias SignUpResult = Result<AuthUser, SignUpError>

typealias SignOutResult = Result<Bool, SignOutError>

typealias AuthValidationResult = Result<Bool, AuthValidationError>
