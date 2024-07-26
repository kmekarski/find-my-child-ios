//
//  SignUpViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    var authManager: AuthManagerProtocol
    
    @Published var textParams: SignUpTextParams = SignUpTextParams()
    @Published var selectedAccountType: UserType? = .parent
    @Published var toast: Toast?
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
    
    func signUp() async {
        guard let type = selectedAccountType else {
            showErrorToast(error: AuthValidationError.signUp(.typeNotSelected))
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
            showErrorToast(error: error)
        }
    }
    
    private func showErrorToast(error: any AuthErrorProtocol) {
        toast = Toast(style: .error, message: error.message)
    }
}

protocol SignUpViewModelDelegate {
    func showSignUpValidationErrorMessage(_ error: AuthValidationError)
}
