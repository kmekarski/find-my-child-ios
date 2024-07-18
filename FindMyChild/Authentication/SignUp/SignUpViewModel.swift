//
//  SignUpViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    var delegate: SignUpViewModelDelegate?
    var authManager: AuthManagerProtocol
    
    @Published var textParams: SignUpTextParams = SignUpTextParams()
    
    @Published var selectedAccountType: UserType? = .parent
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
    
    func signUp() async {
        guard let type = selectedAccountType else {
            delegate?.showSignUpValidationErrorMessage(.signUp(.typeNotSelected))
            return
        }
        let username = textParams.name
        let email = textParams.email
        let password = textParams.password
        let repeatPassword = textParams.repeatPassword
        let phoneNumber = textParams.phoneNumber
        let validationResult = authManager.validateSignUp(
            username: username,
            email: email,
            password: password,
            repeatPassword: repeatPassword,
            phoneNumber: phoneNumber
        )
        switch validationResult {
        case .success(_):
            await authManager.signUp(username: username, email: email, password: password, phoneNumber: phoneNumber, type: type)
        case .failure(let error):
            delegate?.showSignUpValidationErrorMessage(error)
        }
    }
}

protocol SignUpViewModelDelegate {
    func showSignUpValidationErrorMessage(_ error: AuthValidationError)
}
